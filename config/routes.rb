Rails.application.routes.draw do
  resources :commentors
  resources :comments
  resources :posts

  post '/contact', to: 'application#contact'
  post 'resume', to: 'application#resume'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end