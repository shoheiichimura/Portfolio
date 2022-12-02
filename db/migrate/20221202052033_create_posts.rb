class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id
      t.string :title,null: false, default: ""
      t.text :caption,null: false, default: ""
      t.timestamps
    end
  end
end
