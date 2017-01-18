class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from(
    AttrRequired::AttrMissing,
    WebFinger::Exception,
    SWD::Exception,
    JSON::JWT::Exception,
    Rack::OAuth2::Client::Error,
    OpenIDConnect::Exception,
    with: :render_protocol_error
  )

  def render_protocol_error(e)
    @error = e
    logger.info <<~LOG
    # ERROR => #{e.message} (#{e.class})
    LOG
    render '/protocol_error'
  end
end
