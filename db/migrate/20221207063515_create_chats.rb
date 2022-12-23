class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :customer_id
      t.integer :chat_room_id
      t.text :message, null: false

      t.timestamps
    end
  end
end
