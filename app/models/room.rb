class Room < ActiveRecord::Base
    has_many :messages
    has_many :users, through: :messages
    
end