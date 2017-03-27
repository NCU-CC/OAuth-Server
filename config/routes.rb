Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end
  root to: redirect('/oauth/manage/')
  match '/auth/ncu_portal_open_id/callback', to: 'sessions#create', via: [:get, :post]
  get '/oauth/token/old_info/:token_string', to: 'oauth/token_info#show'
  get '/oauth/manage/', to: 'manage#index'
  get '/sign_in', to: 'sessions#index'
  post '/sign_in', to: 'sessions#new'
  match '/sign_out', to: 'sessions#destroy', via: [:get, :delete]
end
