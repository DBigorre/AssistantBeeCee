Rails.application.routes.draw do
  devise_for :users
  resources :links, except: [:show]
  get "questions/new_admin", to: "questions#new_admin"
  post "questions/new_admin", to: "questions#ask", as: :ask
  root to: 'questions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :questions, except: [:show]
  post "questions", to: "questions#create"
  get "questions/answer", to: "questions#answer"

end
  
