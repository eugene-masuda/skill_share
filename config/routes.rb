Rails.application.routes.draw do
  
  root 'pages#home'
  get '/users/:id', to: 'users#show'
  get '/dashboard', to: 'users#dashboard'
  
  post '/users/edit', to: 'users#update'

  resources :gigs do
    member do
      delete :delete_photo
      post :upload_photo
    end
    resources :orders, only: [:create]
  end
  
  devise_for :users, 
  path: '', 
  path_names: { sign_up: 'register', sign_in: 'login', edit: 'profile', sign_out: 'logout' },
  controllers: { registrations: 'registrations' }

end
