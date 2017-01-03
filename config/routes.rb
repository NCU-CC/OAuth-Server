Rails.application.routes.draw do
  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end
  root to: 'dummy#dummy'
  match '/auth/ncu_portal_open_id/callback', to: 'sessions#create', via: [:get, :post]
  get '/oauth/token/old_info/:token_string', to: 'oauth/token_info#show'
end
