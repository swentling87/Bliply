Rails.application.routes.draw do


  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show, :index, :update] do
    resources :locations,  only: [:index, :new, :create, :destroy]
    resources :interests,  only: [:index, :new, :create, :destroy] do
      member do
        put 'stealth'
      end
    end
    resources :friendships, only: [:index, :create, :destroy] do
      member do
        delete 'cancel'
        delete 'decline'
        get 'accept'
      end
    end
    member do
      get 'edit_info'
      put 'stealth'
      resources :posts, only: [:new, :create, :destroy]
    end
  end

  resources :locations, only: [:show] do
    resources :posts, only: [:new, :create, :destroy]
  end

  resources :interests, only: [:show] do
    resources :posts, only: [:new, :create, :destroy]
  end

  root 'welcome#welcome'

  get 'welcome/about'
  get 'welcome/after_sign_up'

end
