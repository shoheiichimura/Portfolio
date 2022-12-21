class Chat < ApplicationRecord
  
  belongs_to :customer
  belongs_to :chat_room
  
  has_many :notifications, dependent: :destroy
  
  has_one_attached :chat_image
  
  validates :message, presence: true, length: { maximum: 140 }
end
