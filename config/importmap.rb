# config/importmap.rb
pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/turbo", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js"
pin "bootstrap", to: "https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"
