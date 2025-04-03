Rails.application.routes.draw do
  root "static_pages#home"

  # Статические страницы
  get "/help",      to: "static_pages#help"
  get "/about",     to: "static_pages#about"
  get "/contact",   to: "static_pages#contact"

  # Аутентификация и авторизация
  get  "/signup",   to: "users#new"
  get  "/login",    to: "sessions#new"
  post "/login",    to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # Управление пользователями
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [ :edit ]
  resources :password_resets,     only: %i[new create edit update]
  resources :microposts,          only: %i[create destroy]
  resources :relationships,       only: %i[create destroy]

  # Дополнительные служебные маршруты
  get "up"              => "rails/health#show",         as: :rails_health_check
  get "service-worker"  => "rails/pwa#service_worker",  as: :pwa_service_worker
  get "manifest"        => "rails/pwa#manifest",        as: :pwa_manifest
end
