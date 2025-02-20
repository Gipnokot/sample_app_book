source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "sassc-rails"
gem "bcrypt"
gem "sqlite3", ">= 1.4"
gem "importmap-rails"
gem "bootstrap-sass", "3.4.1"

gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "mutex_m"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara",                 "3.37.1"
  gem "selenium-webdriver",       "4.29.0"
  gem "webdrivers",               "5.0.0"
  gem "rails-controller-testing", "1.0.5"
  gem "minitest", "~> 5.25", ">= 5.25.4"
  gem "minitest-reporters", "~> 1.7", ">= 1.7.1"
  gem "guard",                    "2.18.0"
  gem "guard-minitest",           "2.4.6"
end

group :production do
  gem "pg", "1.3.5"
  gem "puma", ">= 5.0"
end
