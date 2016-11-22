Rails.application.routes.draw do
  use_doorkeeper
  root to: redirect('/oauth/manage/')
  match '/auth/ncu_portal_open_id/callback', to: 'sessions#create', via: [:get, :post]
  get '/oauth/manage/', to: 'manage#index'
  match '/logout', to: 'sessions#destroy', via: [:get, :delete]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
