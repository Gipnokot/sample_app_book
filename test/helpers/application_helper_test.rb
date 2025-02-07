# test/helpers/application_helper_test.rb
require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    # Проверка заголовка без аргумента
    assert_equal "Ruby on Rails Tutorial Sample App", full_title

    # Проверка заголовка с аргументом
    assert_equal "Help | Ruby on Rails Tutorial Sample App", full_title("Help")
    assert_equal "About | Ruby on Rails Tutorial Sample App", full_title("About")
    assert_equal "Contact | Ruby on Rails Tutorial Sample App", full_title("Contact")
  end
end
