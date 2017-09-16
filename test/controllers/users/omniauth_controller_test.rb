require 'test_helper'

class Users::OmniauthControllerTest < ActionDispatch::IntegrationTest
  test "should get Callbacks" do
    get users_omniauth_Callbacks_url
    assert_response :success
  end

end
