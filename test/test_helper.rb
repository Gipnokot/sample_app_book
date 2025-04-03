ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'

Minitest::Reporters.use!

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)

    fixtures :all
    include ApplicationHelper

    # Проверяет, залогинен ли пользователь
    def is_logged_in?
      !session[:user_id].nil?
    end

    # Логин пользователя для unit-тестов
    def log_in_as(user, remember_me: '1')
      post login_path, params: { session: { email: user.email,
                                            password: 'password',
                                            remember_me: remember_me } }
    end
  end
end

module ActionDispatch
  class IntegrationTest
    # Логин пользователя в интеграционных тестах
    def log_in_as(user, remember_me: '0')
      post login_path,
           params: { session: { email: user.email, password: 'password',
                                remember_me: remember_me } }
    end

    def setup
      # Очистка cookies через Rack::Test
      @request ||= ActionDispatch::Request.new(Rack::MockRequest.env_for('/'))
      @request.cookie_jar.clear
    end
  end
end
