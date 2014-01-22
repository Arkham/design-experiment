DesignExperiment::Application.routes.draw do
  root 'members#index'

  resources :members do
    member do
      get :search_connections
    end
  end
  resources :friendships, only: [:create, :destroy]
end
