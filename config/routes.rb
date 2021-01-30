Rails.application.routes.draw do
  resources :users
  resources :posts, only: [:index, :new, :create] do
    resources :comments
  end
  resources :comments do
    resources :subcomments, controller: :comments
  end
  
  get '/posts/:id', to: 'posts#show', id: /\d+/
  get 'posts/:slug', to: 'posts#show'
  get '/posts/:id/edit', to: 'posts#edit', id: /\d+/
  get 'posts/:slug/edit', to: 'posts#edit'
  patch '/posts/:id', to: 'posts#update', id: /\d+/
  patch 'posts/:slug', to: 'posts#update'
  put '/posts/:id', to: 'posts#edit', id: /\d+/
  put 'posts/:slug', to: 'posts#edit'
  delete '/posts/:id', to: 'posts#destroy', id: /\d+/
  delete 'posts/:slug', to: 'posts#destroy'

  post '/contact', to: 'application#contact'
  post 'resume', to: 'application#resume'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
