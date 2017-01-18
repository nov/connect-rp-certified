class Client < ApplicationRecord
  belongs_to :test_case

  def agent_for(config, options = {})
    OpenIDConnect::Client.new(
      identifier:             identifier,
      secret:                 secret,
      authorization_endpoint: config.authorization_endpoint,
      token_endpoint:         config.token_endpoint,
      userinfo_endpoint:      config.userinfo_endpoint,
      redirect_uri:           options[:redirect_uri]
    )
  end
end
