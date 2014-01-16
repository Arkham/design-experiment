DesignExperiment::Application.routes.draw do
  root 'members#index'

  resources :members, only: [:index, :new, :create, :show]
end
