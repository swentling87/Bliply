Rails.application.routes.draw do


  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show, :index, :update] do
    resources :locations,  only: [:index, :new, :create, :destroy]
    resources :interests,  only: [:index, :new, :create, :destroy]
    member do
      get 'edit_info'
    end
  end

  root 'welcome#welcome'

  get 'welcome/about'
  get 'welcome/after_sign_up'

end
