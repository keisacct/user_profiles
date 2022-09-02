Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations', 
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: "questions#index"
  resources :users, only: [:show, :edit, :update]
  resources :stayed_countries, only: [:new, :create, :edit, :update]
end
