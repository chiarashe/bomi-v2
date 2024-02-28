Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :doctors, controllers: { registrations: 'doctors/registrations' }
  devise_for :patients, controllers: { registrations: 'patients/registrations' }

  root to: "pages#home"
  get "dashboard/doctor", to: "pages#dashboard_doctor"
  get "dashboard/patient", to: "pages#dashboard_patient"
  get '/shared/:id/:token', to: 'shared#show', as: 'shared'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :doctors, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :reports do
    resources :recommendations
    end
  end
  resources :patients, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :reports, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :questions
    end
  end
  resources :recommendations, only: [:destroy, :edit, :update]
  resources :relations, only: [:destroy, :create]
  resources :contents, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
