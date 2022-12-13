class ChatRoom < ApplicationRecord
  
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :customers, through: :user_rooms
end
