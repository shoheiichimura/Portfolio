class Public::ChatRoomsController < ApplicationController
   before_action :authenticate_customer!

  def create
    current_customer_chat_rooms = UserRoom.where(customer_id: current_customer.id).map(&:chat_room)
    chat_room = UserRoom.where(chat_room: current_user_chat_rooms, user_id: params[:customer_id]).map(&:chat_room).first
    if chat_room.blank?
      chat_room = ChatRoom.create
      UserRoom.create(chat_room: chat_room, customer_id: current_customer.id)
      UserRoom.create(chat_room: chat_room, customer_id: params[:customer_id])
    end
    redirect_to action: :show, id: chat_room.id
  end

  def show
  end
end
