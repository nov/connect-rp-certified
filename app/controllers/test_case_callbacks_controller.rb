class TestCaseCallbacksController < ApplicationController
  layout 'popup'

  before_action :reject_csrf

  def show
    @access_token, @id_token, @id_token_jwt, @user_info = TestCase.validate!(
      params[:id],
      client_id:    session[:client_id],
      nonce:        session[:nonce],
      code:         params[:code],
      redirect_uri: test_case_callback_url(params[:id])
    )
  end

  private

  def reject_csrf
    unless params[:state] == session[:state]
      render text: 'CSRF Attack Detected'
    end
  end
end
