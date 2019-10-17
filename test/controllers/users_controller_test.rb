require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: "", email: "user@invalid", character: "buyer",
                                       password: "foo", password_confirmation: "bar"}}
    end
    assert_template 'users/new'
  end
end
