class TestCase < ApplicationRecord
  RP_CERTIFICATION_SITE = 'https://rp.certification.openid.net:8080'
  RP_IDENTIFIER = 'nov-rp-certified'

  before_validation :setup, on: :create
  validates :identifier, presence: true, uniqueness: true
  validates :issuer,     presence: true, uniqueness: true

  private

  def setup
    self.issuer = if identifier
      File.join(RP_CERTIFICATION_SITE, RP_IDENTIFIER, identifier)
    end
  end
end
