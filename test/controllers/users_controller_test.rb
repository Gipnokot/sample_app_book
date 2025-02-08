require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "flash is not empty after create" do
    post users_path, params: { user: { name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password" } }
    assert_not flash.empty?, "Flash should not be empty after user creation"
  end
end
