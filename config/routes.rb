Rails.application.routes.draw do
  root 'pages#home'
  get '/dashboard', to: 'users#dashboard'
  post '/users/edit', to: 'users#update'
  devise_for :users, 
  path: '', 
  path_names: { sign_up: 'register', sign_in: 'login', edit: 'profile', sign_out: 'logout' },
  controllers: { registrations: 'registrations' }

end
