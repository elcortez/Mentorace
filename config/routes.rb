Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/about/' => 'pages#about', as: :about

  resources :users, only: :show

  resources :courses, only: :index do
    resources :chapter, only: [] do
      resources :unit, only: :show
    end
  end
end
