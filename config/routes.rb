Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :links, except: [:show]
  resources :questions, except: [:show]
end
