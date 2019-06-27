Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#heartbeat'

  post '/signup', to: 'users#create'
  get 'users/:id', to: 'users#show'

  get 'users/:user_id/repos', to: 'repositories#index'
  post 'users/:user_id/repos', to: 'repositories#create'
  get 'users/:user_id/repos/:id', to: 'repositories#show'
  delete 'users/:user_id/repos/:id', to: 'repositories#destroy'
end
