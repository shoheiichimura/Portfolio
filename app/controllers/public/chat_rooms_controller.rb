class Public::ChatRoomsController < ApplicationController
  before_action :authenticate_customer!

  def index
    # ログインユーザーが入っているルームID取得
     @current_user_rooms = current_customer.user_rooms
     my_room_id = []
     # byebug
     @current_user_rooms.each do |user_room|
      my_room_id << user_room.chat_room.id
     end
     # 自分のchat_room_idでcustomer_idが自分じゃないのを取得
     @another_user_rooms = UserRoom.where(chat_room_id: my_room_id).where('customer_id != ?', current_customer.id)
     @chat = current_customer.chats
     if @chat.exists?
     # トークの最後のメッセージを取得
     @last_message = Chat.find_by(chat_room_id: @another_user_rooms.last.chat_room_id).message
     end
  end

end