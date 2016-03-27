Rails.application.routes.draw do


  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show, :index]
  root 'welcome#welcome'

  get 'welcome/about'
  get 'welcome/after_sign_up'

end
