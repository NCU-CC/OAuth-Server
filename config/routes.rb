Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end
  root to: redirect('/oauth/manage/')
  get 'oauth/token/old_info/:token_string', to: 'token_info#show'
  get 'oauth/manage', to: 'manage#index'
  get 'oauth/users', to: 'users#index'
  get 'oauth/users/:id', to: 'users#show', as: 'oauth_user'
  get 'oauth/owners', to: 'authorization_server_owners#index'
  match 'auth/ncu_portal_open_id/callback', to: 'sessions#create', via: [:get, :post]
  post 'sign_in', to: 'sessions#new'
  get 'sign_in', to: 'sessions#index'
  match 'sign_out', to: 'sessions#destroy', via: [:get, :delete]
end
