class Chat < ApplicationRecord
  
  belongs_to :customer
  belongs_to :chat_room
  
  validates :message, presence: true, length: { maximum: 140 }
end
