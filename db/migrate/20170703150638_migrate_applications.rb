class OldApplication < ApplicationRecord
  self.table_name = 'client'
  has_many :old_access_tokens, foreign_key: 'client_id'
end

class OldAccessToken < ApplicationRecord
  self.table_name = 'access_token'
  belongs_to :old_application, foreign_key: 'client_id'
  has_and_belongs_to_many :old_permissions,
    join_table: 'access_token_scope',
    foreign_key: 'access_token_id',
    association_foreign_key: 'permission_id'
end

class OldPermission < ApplicationRecord
  self.table_name = 'permission'
  has_and_belongs_to_many :old_access_tokens,
    join_table: 'access_token_scope',
    foreign_key: 'permission_id',
    association_foreign_key: 'access_token_id'
end

class MigrateApplications < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        say_with_time 'adding applications' do
          OldApplication.all.each do |old_application|
            application = Doorkeeper::Application.new({
              id: old_application.id,
              name: old_application.name,
              uid: old_application.serial_id,
              secret: old_application.encrypted_secret,
              redirect_uri: old_application.callback,
              created_at: old_application.date_created,
              updated_at: old_application.last_updated,
              owner_id: old_application.owner_id,
              owner_type: 'User'
            })
            permissions = old_application.old_access_tokens.map(&:old_permissions).flatten!
            application.scopes = if permissions
                                   permissions.uniq!.map!(&:name).join(' ')
                                 else
                                   ''
                                 end
            application.save
          end.size
        end
      end
      dir.down do
        say 'nothing to do'
      end
    end
  end
end
