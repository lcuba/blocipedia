Rails.application.routes.draw do



  get 'downgrade/new'

  get 'downgrade/create'

  devise_for :users, controllers: {registrations: "registrations"}
  
  get 'welcome/index'
  
  get 'welcome/about'
  
  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end
  
  resources :charges, only: [:new, :create]
  
  resources :downgrade, only: [:new, :create]

  root 'welcome#index'
end
