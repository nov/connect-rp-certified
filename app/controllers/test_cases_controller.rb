class TestCasesController < ApplicationController
  layout 'popup'

  def show
    client = TestCase.register_client!(
      params[:id],
      redirect_uri: test_case_callback_url(params[:id])
    )

    session[:client_id] = client.identifier
    session[:state] = SecureRandom.hex(16)
    session[:nonce] = SecureRandom.hex(16)

    redirect_to client.authorization_uri(
      state: session[:state],
      nonce: session[:nonce],
      scope: [:profile, :email, :address, :phone]
    )
  end
end
