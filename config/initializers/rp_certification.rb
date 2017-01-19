rp_identifier = if ENV['RP_IDENTIFIER'].present?
  ENV['RP_IDENTIFIER']
else
  ['nov-rp-certified', SecureRandom.hex(8)].join('-')
end

if rp_identifier.blank?
  raise 'RP Identifier required.'
else
  puts "=> Start RP as '#{rp_identifier}'"
end

Rails.application.config.rp_ceritification = {
  certified: ENV['RP_CERTIFIED'],
  idp_base_url: 'https://rp.certification.openid.net:8080',
  rp_identifier: rp_identifier
}