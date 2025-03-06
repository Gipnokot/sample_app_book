require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  # Создание пользователя перед тестом
  def setup
    @user = User.create!(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password")
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: "password" } }

    # Проверка, что пользователь залогинен
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!

    # Убедитесь, что мы на странице пользователя
    assert_template "users/show"

    # Печатаем информацию о текущей странице для отладки
    puts "Current page: #{response.body}"

    # Проверка наличия ссылки на logout
    assert_select "form[action=?]", logout_path

    # Логика выхода
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
    log_in_as(@user, remember_me: "1")
    assert_not_empty cookies["remember_token"] # Проверяем, что токен установлен
    assert_equal assigns(:user).remember_token, cookies["remember_token"]
  end

  test "login without remembering" do
    # Логинимся с включенным remember_me
    log_in_as(@user, remember_me: "1")
    # Логинимся снова, но без remember_me
    log_in_as(@user, remember_me: "0")
    assert_empty cookies["remember_token"] # Проверяем, что куки удалены
  end
end
