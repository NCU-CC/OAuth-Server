class AddAuthorizationServerOwnerToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :authorization_server_owner, :boolean
  end
end
