Rails.application.routes.draw do
  devise_for :users
  root 'welcome#welcome'

  get 'welcome/about'

end
