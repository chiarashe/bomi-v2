Rails.application.routes.draw do
  devise_for :doctors
  devise_for :patients
  root to: "pages#home"
  get "dashboard/doctor", to: "pages#dashboard_doctor"
  get "dashboard/patient", to: "pages#dashboard_patient"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
