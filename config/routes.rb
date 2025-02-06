Rails.application.routes.draw do
  root "static_pages#home"
  get  "static_pages/home"
  get  "static_pages/help"
  get  "static_pages/about"
  get "static_pages/contact"





  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
