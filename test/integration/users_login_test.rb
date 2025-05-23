require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: "password" } }

    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_select "form[action=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    post login_path, params: { session: { email: @user.email,
                                          password: "password",
                                          remember_me: "1" } }
    assert_not_nil cookies["remember_token"]
    assert_equal cookies["remember_token"], assigns(:user).remember_token
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: "1")
    assert_not_nil cookies["remember_token"]
    log_in_as(@user, remember_me: "0")
    assert_nil cookies["remember_token"]
  end
end
