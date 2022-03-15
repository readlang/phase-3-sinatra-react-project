class User < ActiveRecord::Base
    has_many :messages
    has_many :rooms, through: :messages
    
end