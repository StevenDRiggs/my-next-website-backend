Rails.application.routes.draw do

  post '/contact', to: 'application#contact'
  post 'resume', to: 'application#resume'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
