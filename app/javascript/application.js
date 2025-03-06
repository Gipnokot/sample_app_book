import "@hotwired/turbo-rails"; // Turbo должен остаться
import "controllers";
import jquery from "jquery";
import "bootstrap";

// Сделаем jQuery доступным глобально (если нужно)
window.$ = window.jQuery = jquery;
