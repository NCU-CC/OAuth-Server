class OldUser < ApplicationRecord
  self.table_name = 'user'
end

class MigrateUsers < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        say_with_time 'adding users' do
          OldUser.all.each do |old_user|
            User.create({
              id: old_user.id,
              portal_id: old_user.name,
              created_at: old_user.date_created,
              updated_at: old_user.last_updated
            })
          end.size
        end
      end
      dir.down do
        say 'nothing to do'
      end
    end
  end
end
