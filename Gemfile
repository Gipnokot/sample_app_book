source "https://rubygems.org"

gem "bcrypt"
gem "bootsnap", require: false
gem "bootstrap-sass", "3.4.1"
gem "carrierwave"
gem "faker"
gem "importmap-rails"
gem "jbuilder"
gem "mini_magick"
gem "rails", "~> 7.2.1"
gem "sassc-rails"
gem "sqlite3", ">= 1.4"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "will_paginate", "~> 3.3"

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "mutex_m"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "dotenv-rails"
  gem "web-console"
end

group :test do
  gem "capybara", "3.37.1"
  gem "guard", "2.18.0"
  gem "guard-minitest", "2.4.6"
  gem "minitest", "~> 5.25", ">= 5.25.4"
  gem "minitest-reporters", "~> 1.7", ">= 1.7.1"
  gem "rails-controller-testing", "1.0.5"
  gem "selenium-webdriver", "4.31.0"
  gem "webdrivers", "5.0.0"
end

group :production do
  gem "pg", "1.3.5"
  gem "puma", ">= 5.0"
end

gem "rubocop-performance", "~> 1.23", group: :development
gem "rubocop-rails", "~> 2.29", group: :development
gem "rubocop-rspec", "~> 3.4", group: :development
