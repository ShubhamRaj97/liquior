Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  namespace :admin do
    resources :stores
    # resources :users, only: [:create]
    post 'users/register', to: 'users#create'
  end

    namespace :api do
      namespace :v1 do
        get 'me', to: 'users#me'  # Optional: Get current user info
      end
    end  
 
end
