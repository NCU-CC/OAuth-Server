class User < ApplicationRecord
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner
end
