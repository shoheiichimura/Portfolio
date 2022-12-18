class Chat < ApplicationRecord
  
  belongs_to :customer
  belongs_to :chat_room
  
  has_many :notifications, dependent: :destroy
  
  validates :message, presence: true, length: { maximum: 140 }
end
