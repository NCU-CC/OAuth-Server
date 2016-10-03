Rails.application.routes.draw do
  use_doorkeeper
  root to: 'dummy#dummy'
  match '/auth/ncu_portal_open_id/callback', to: 'sessions#create', via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
