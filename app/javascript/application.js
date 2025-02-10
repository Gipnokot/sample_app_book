// app/javascript/application.js
import "@hotwired/turbo-rails" // Turbo должен остаться
import "controllers"
import "jquery"
import "bootstrap"

// Сделаем jQuery доступным глобально (если нужно)
window.$ = window.jQuery = require('jquery');
