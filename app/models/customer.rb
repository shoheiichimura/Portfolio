class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum sex: { man: 0, woman: 1 }
  enum ride_area:{
     "---":0,
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47
   }
   enum objective_muscle:{
     "---":0,
     健康のため:1,見た目を良くしたい:2,絞りたい:3,筋肉を付けたい:4,大会意識:5
   }
   enum frequency_muscle:{
     "---":0,
     月１回〜３回:1,週２回〜３回:2,週３回〜４回:3,週５回以上:4
   }
   enum traning_style_muscle:{
     "---":0,
     会員制ジム:1,自宅:2,パーソナル:3
   }
   enum heart_muscle:{
     "---":0,
     無理せずゆる〜く続けたい:1,適度に追い込むタイプ:2,ストイックにとことん！:3,
   }




end
