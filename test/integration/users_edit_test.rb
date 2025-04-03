# test/integration/users_edit_test.rb

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    assert_redirected_to login_url
    log_in_as(@user)
    follow_redirect!
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: 'New Name', email: 'new@example.com' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: '', email: 'invalid@user' } }
    assert_template 'users/edit'
    assert_select 'div.alert-danger', count: 1
  end
end
