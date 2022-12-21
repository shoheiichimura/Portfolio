class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id]) #チャットする相手は誰か？
    chat_rooms = current_customer.user_rooms.pluck(:chat_room_id) #ログイン中のユーザーの部屋情報を全て取得
     # user_roomモデルから
     # customer_idがチャット相手のidが一致するものと、
     # chat_room_idが上記chat_roomsのどれかに一致するレコードを
     # user_roomsに代入。
    user_rooms = UserRoom.find_by(customer_id: @customer.id, chat_room_id: chat_rooms)

    unless user_rooms.nil?  # もしuser_roomが空でないなら
      @chat_room = user_rooms.chat_room #変数@chat_roomにユーザー（自分と相手）と紐づいているchat_roomを代入
    else  #ユーザールームが無かった場合
      @chat_room = ChatRoom.new # それ以外は新しくroomを作り、
      @chat_room.save  #そして保存
       # user_roomをカレントユーザー分とチャット相手分を作る
      UserRoom.create(customer_id: current_customer.id, chat_room_id: @chat_room.id) #自分の中間テーブルを作る
      UserRoom.create(customer_id: @customer.id, chat_room_id: @chat_room.id) #相手の中間テーブルを作る
    end
    @chats = @chat_room.chats  #チャットの一覧用の変数
    @chat = Chat.new(chat_room_id: @chat_room.id)  #チャットの投稿用の変数
  end

  def create
    @chat = current_customer.chats.new(chat_params)
    @customer = current_customer
    @chat.save
     # 新規作成された@chatに紐づくchat_roomを@chat_roomに格納する
    @chat_room = @chat.chat_room
    # 本引数を２つ持たせてcreate_notification_dmメソッドを実行
    @chat_room.create_notification_dm!(current_customer, @chat.id)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :chat_room_id, :chat_image)
  end

  def reject_non_related
    customer = Customer.find(params[:id])
    unless current_customer.following?(customer) && customer.following?(current_customer)
      redirect_to customers_path
    end
  end
end
