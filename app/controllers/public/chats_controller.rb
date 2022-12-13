class Public::ChatsController < ApplicationController

  before_action :reject_non_related, only: [:show]

  def show
    @customer = Customer.find(params[:id]) #チャットする相手は誰か？
    chat_rooms = current_customer.user_rooms.pluck(:chat_room_id) #ログイン中のユーザーの部屋情報を全て取得
    user_rooms = UserRoom.find_by(customer_id: @customer.id, chat_room_id: chat_rooms)#その中にチャットする相手とのルームがあるか確認

    unless user_rooms.nil? #ユーザールームが無くなかった
      @chat_room = user_rooms.chat_room #変数@chat_roomにユーザー（自分と相手）と紐づいているchat_roomを代入
    else  #ユーザールームが無かった場合
      @chat_room = ChatRoom.new#新しくChat_Roomを作る
      @chat_room.save  #そして保存
      UserRoom.create(customer_id: current_customer.id, chat_room_id: @chat_room.id) #自分の中間テーブルを作る
      UserRoom.create(customer_id: @customer.id, chat_room_id: @chat_room.id) #相手の中間テーブルを作る
    end
    @chats = @chat_room.chats  #チャットの一覧用の変数
    @chat = Chat.new(chat_room_id: @chat_room.id)  #チャットの投稿用の変数
  end
  
  def create
    @chat = current_customer.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :chat_room_id)
  end

  def reject_non_related
    customer = Customer.find(params[:id])
    unless current_customer.following?(customer) && customer.following?(current_customer)
      redirect_to customers_path
    end
  end
end
