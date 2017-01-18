class TestCase < ApplicationRecord
  RP_CERTIFICATION_SITE = 'https://rp.certification.openid.net:8080'
  RP_IDENTIFIER = ENV['RP_IDENTIFIER'] || 'nov-rp-certified'

  has_many :clients

  before_validation :setup, on: :create
  validates :identifier, presence: true, uniqueness: true
  validates :issuer,     presence: true, uniqueness: true

  class << self
    def register_client!(identifier, options = {})
      test_case = find_or_create_by!(identifier: identifier)
      client = test_case.register_client! options
    end

    def validate!(identifier, options = {})
      test_case = find_by!(identifier: identifier)
      test_case.validate! options
    end
  end

  def register_client!(options = {})
    client = OpenIDConnect::Client::Registrar.new(
      config.registration_endpoint,
      client_name:      "NOV RP - #{identifier}",
      application_type: 'web',
      redirect_uris:    [options[:redirect_uri]]
    ).register!
    client = clients.create!(
      identifier: client.identifier,
      secret:     client.secret
    )
    client.agent_for config, options
  end

  def validate!(options = {})
    access_token, id_token, id_token_jwt = if options[:code].present?
      validate_token_request! options
    end
    user_info = if access_token.present?
      validate_user_info! access_token, id_token, options
    end
    [access_token, id_token, id_token_jwt, user_info]
  end

  private

  def validate_token_request!(options = {})
    client = clients.find_by!(identifier: options[:client_id])
    client = client.agent_for config, options
    client.authorization_code = options[:code]
    access_token = client.access_token!
    id_token, id_token_jwt = validate_id_token! access_token.id_token, config.jwks, options
    [access_token, id_token, id_token_jwt]
  end

  def validate_id_token!(id_token_string, jwks, options = {})
    id_token_jwt = JSON::JWT.decode id_token_string, :skip_verification
    id_token = if id_token_jwt.header[:alg] == 'none'
      OpenIDConnect::ResponseObject::IdToken.decode id_token_string, :skip_verification
    else
      jwk_or_jwks = if id_token_jwt.header[:kid].present?
        jwks
      else
        expectd_kty = case id_token_jwt.header[:alg]
        when /RS/
          'RSA'
        when /ES/
          'EC'
        end
        jwks_selected = jwks.select do |jwk|
          jwk[:use] == 'sig' && jwk[:kty] == expectd_kty
        end
        case jwks_selected.size
        when 0
          raise JSON::JWK::Set::KidNotFound, "No keys are found for kyt=#{expectd_kty} & use=sig"
        when 1
          jwks.first
        else
          raise JSON::JWK::Set::KidNotFound, "Multiple keys are found for kyt=#{expectd_kty} & use=sig"
        end
      end
      OpenIDConnect::ResponseObject::IdToken.decode id_token_string, jwk_or_jwks
    end
    id_token.verify!(
      issuer:   issuer,
      audience: options[:client_id],
      nonce:    options[:nonce]
    )
    [id_token, id_token_jwt]
  end

  def validate_user_info!(access_token, id_token, options = {})
    user_info = access_token.userinfo!
    if id_token.sub != user_info.sub
      raise OpenIDConnect::Exception, '"sub" mismatch between ID Token and UserInfo'
    end
    user_info
  end

  def config
    @config ||= OpenIDConnect::Discovery::Provider::Config.discover! issuer
  end

  def setup
    self.issuer = if identifier
      File.join(RP_CERTIFICATION_SITE, RP_IDENTIFIER, identifier)
    end
  end
end
