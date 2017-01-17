class TestCasesController < ApplicationController
  def show
    test_case = TestCase.find_or_create_by!(identifier: params[:id])
    # TODO:
    # client = test_case.register_client!

    case test_case.identifier
    when 'foo'
    when 'bar'
    else
      # redirect_to client.authorization_uri(...)
    end
    render text: test_case.issuer
  end
end
