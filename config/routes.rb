DesignExperiment::Application.routes.draw do
  root 'members#index'

  resources :members
  resources :friendships, only: [:create, :destroy]
end
