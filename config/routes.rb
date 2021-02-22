Rails.application.routes.draw do
  resources :users, except: :create

  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout'

  resources :posts, only: [:index, :create] do
    resources :comments
  end
  resources :comments do
    resources :subcomments, controller: :comments
  end
  
  get '/posts/:id', to: 'posts#show', id: /\d+/
  get '/posts/:slug', to: 'posts#show'

  patch '/posts/:id', to: 'posts#update', id: /\d+/
  patch '/posts/:slug', to: 'posts#update'

  delete '/posts/:id', to: 'posts#destroy', id: /\d+/
  delete '/posts/:slug', to: 'posts#destroy'

  post '/verifylogin', to: 'application#verify_login'

  post '/contact', to: 'application#contact'
  post '/resume', to: 'application#resume'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
