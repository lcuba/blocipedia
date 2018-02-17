Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  
  get 'welcome/index'
  
  get 'welcome/about'
  
  resources :wikis

  root 'welcome#index'
end
