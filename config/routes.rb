Rails.application.routes.draw do
  
  
  get 'message/create'
  root 'pages#home'
  get '/users/:id', to: 'users#show', as: 'users'
  get '/dashboard', to: 'users#dashboard'
  get '/selling_orders', to: 'orders#selling_orders'
  get '/buying_orders', to: 'orders#buying_orders'
  get '/all_requests', to: 'requests#list'
  get '/search', to: 'pages#search'
  get '/my_offers', to: 'requests#my_offers'
  get '/request_offers/:id', to: 'requests#offers', as: 'request_offers'
  get '/settings/payment', to: 'users#payment', as: 'settings_payment'
  get '/settings/payout', to: 'users#payout', as: 'settings_payout'
  get '/gigs/:id/checkout/:pricing_type', to: 'gigs#checkout', as: 'checkout'
  get '/earnings', to: 'users#earnings', as: 'earnings'

  post '/users/edit', to: 'users#update'
  post '/offers', to: 'offers#create'
  post '/reviews', to: 'reviews#create'
  post '/settings/payment', to: 'users#update_payment', as: "update_payment"
  post '/settings/payout', to: 'users#update_payout', as: "update_payout"
  post '/users/withdraw', to: 'users#withdraw', as: 'withdraw'
  post 'messages', to: 'messages#create'
  post '/comments', to: 'comments#create'
  post '/subscribe', to: 'subscriptions#subscribe'
  post '/webhook', to: 'subscriptions#webhook'

  put '/orders/:id/complete', to: 'orders#complete', as: 'complete_order'
  put '/offers/:id/accept', to: 'offers#accept', as: 'accept_offer'
  put '/offers/:id/reject', to: 'offers#reject', as: 'reject_offer'

  resources :gigs do
    member do
      delete :delete_photo
      post :upload_photo
    end
    resources :orders, only: [:create]
  end

  resources :requests
  
  devise_for :users, 
  path: '', 
  path_names: { sign_in: 'login', edit: 'profile', sign_out: 'logout' },
  controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

end
