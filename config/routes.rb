Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/about/' => 'pages#about', as: :about

  resources :users, only: :show

  resources :courses, only: :index do
    resources :chapters, only: [] do
      resources :units, only: :show do
        resources :unit_exercises, only: [] do
          resources :exercise_attempts, only: [:new, :create]
        end
      end
    end
  end
end
