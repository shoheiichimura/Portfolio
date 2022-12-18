class ChatRoom < ApplicationRecord
  
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :customers, through: :user_rooms
  has_many :notifications, dependent: :destroy
  
  def create_notification_dm!(current_customer, chat_id)
    # ユーザールームからcustomer_idが自分と同じものを省いて
    # chat_room_idが生成されたチャットルームIDと一致する
    multiple_user_room = UserRoom.where(chat_room_id: id).where.not(customer_id: current_customer.id)
    # 複数レコードだったものを単一レコードに変換
    single_user_room = multiple_user_room.find_by(chat_room_id: id)
    # 現在のユーザーに紐づくactive_notificationsに()内の各データを入れて作成
    notification = current_customer.active_notifications.new(
      chat_room_id: id,
      chat_id: chat_id,
      visited_id: single_user_room.customer_id,
      action: 'dm'
    )
    notification.save if notification.valid?
  end
  
  
end
