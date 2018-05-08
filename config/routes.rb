Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/about/' => 'pages#about', as: :about

  resources :users, only: :show

  resources :courses, only: [:index, :show] do
    resources :chapters, only: [] do
      resources :lessons, only: :show do
        resources :exercises, only: [] do
          resources :attempts, only: [:new, :create]
        end
      end
    end
  end
end
