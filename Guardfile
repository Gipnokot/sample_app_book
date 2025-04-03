require 'active_support/inflector'

guard :minitest, all_on_start: false do
  # Общий watch для моделей, почтовых отправителей и контроллеров
  watch_models
  watch_mailers
  watch_controllers
  watch_views
  watch_misc
end

# Watch для моделей
def watch_models
  watch(%r{^app/models/(.*?)\.rb$}) do |matches|
    ["test/models/#{matches[1]}_test.rb", 'test/integration/microposts_interface_test.rb']
  end
  watch(%r{^test/fixtures/(.*?)\.yml$}) do |matches|
    "test/models/#{matches[1].singularize}_test.rb"
  end
end

# Watch для почтовых отправителей
def watch_mailers
  watch(%r{^app/mailers/(.*?)\.rb$}) do |matches|
    "test/mailers/#{matches[1]}_test.rb"
  end
  watch(%r{^app/views/(.*)_mailer/.*$}) do |matches|
    "test/mailers/#{matches[1]}_mailer_test.rb"
  end
end

# Watch для контроллеров
def watch_controllers
  watch(%r{^app/controllers/(.*?)_controller\.rb$}) do |matches|
    resource_tests(matches[1])
  end
  watch('app/controllers/sessions_controller.rb') do
    ['test/controllers/sessions_controller_test.rb', 'test/integration/users_login_test.rb']
  end
  watch('app/controllers/account_activations_controller.rb') do
    'test/integration/users_signup_test.rb'
  end
  watch('app/controllers/relationships_controller.rb') do
    ['test/controllers/relationships_controller_test.rb', 'test/integration/following_test.rb']
  end
end

# Watch для видов
def watch_views
  watch('app/views/layouts/application.html.erb') do
    'test/integration/site_layout_test.rb'
  end
  watch('app/views/layouts/*') { interface_tests }
  watch(%r{^app/views/([^/]*?)/.*\.html\.erb$}) do |matches|
    ["test/controllers/#{matches[1]}_controller_test.rb"] + integration_tests(matches[1])
  end
  watch('app/views/users/*') do
    resource_tests('users') + ['test/integration/microposts_interface_test.rb']
  end
end

# Watch для misc файлов (например, тесты или файлы конфигурации)
def watch_misc
  watch('test/test_helper.rb') { 'test' }
  watch('config/routes.rb') { interface_tests }
  watch('app/helpers/sessions_helper.rb') do
    integration_tests << 'test/helpers/sessions_helper_test.rb'
  end
end

# Возвращает все интеграционные тесты для данного ресурса
def integration_tests(resource = :all)
  resource == :all ? Dir['test/integration/*'] : Dir["test/integration/#{resource}_*.rb"]
end

# Возвращает все тесты для интерфейса
def interface_tests
  integration_tests << 'test/controllers'
end

# Возвращает все тесты для контроллера ресурса
def controller_test(resource)
  "test/controllers/#{resource}_controller_test.rb"
end

# Возвращает все тесты для ресурса
def resource_tests(resource)
  integration_tests(resource) << controller_test(resource)
end
