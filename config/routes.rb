Rails.application.routes.draw do
  root to: redirect('/oauth/manage')

  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end

  namespace :oauth do
    get 'manage', to: 'manage#index'
    get 'token/old_info/:token_string', to: 'token_info#show'
    resources :users, only: [:index, :update, :show]
    resources :owners, only: [:index, :destroy], controller: 'authorization_server_owners'
    resources :disabled_users, only: [:index, :destroy]
  end

  match 'auth/ncu_portal_open_id/callback', to: 'sessions#create', via: [:get, :post]
  post 'sign_in', to: 'sessions#new'
  get 'sign_in', to: 'sessions#index'
  match 'sign_out', to: 'sessions#destroy', via: [:get, :delete]
end
