DesignExperiment::Application.routes.draw do
  root 'members#index'

  resources :members
end
