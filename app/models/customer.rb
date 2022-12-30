class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  validates :name, presence: true,length: { in: 2..20 }
  validates :introduction, presence: true, length: { maximum: 200 }
  validates :sex, presence: true
  validates :history, presence: true
  validates :active_area, presence: true
  validates :objective, presence: true
  validates :frequency, presence: true
  validates :heart, presence: true
  validates :traning_style, presence: true
  validates :profile_image, presence: true
  
  has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
 

  # ゲストログイン
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com',introduction: "ゲスト",sex: 0,active_area: 0,objective: 0,frequency: 0,heart: 0,traning_style: 0) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestuser"
      customer.email = 'guest@example.com'
      customer.introduction = "ゲスト"
      customer.sex = 0
      customer.active_area = 0
      customer.objective = 0
      customer.frequency = 0
      customer.heart = 0
      customer.traning_style = 0
      customer.profile_image.attach(io: File.open(Rails.root.join("app/assets/images/no_image.jpg")), filename: "no_image.jpg") 
    end
  end

# プロフィール画像
  def get_profile_image(width, height)
   unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
   end
   profile_image.variant(resize_to_limit: [width, height]).processed
  end

 # 新規登録時のenum記述
  enum sex: { man: 0, woman: 1 }

  enum active_area:{ hokkaido:0,aomori:1,iwate:2,miyagi:3,akita:4,yamagata:5,hukusima:6,
     ibaraki:7,totigi:8,gunma:9,saitama:10,tiba:11,tokyo:12,kanagawa:13,
     niigata:14,toyama:15,isikawa:16,hukui:17,yamanasi:18,nagano:19,
     gihu:20,sizuoka:21,aiti:22,mie:23,
     siga:24,kyoto:25,oosaka:26,hyougo:27,nara:28,wakayama:29,
     tottori:30,simane:31,okayama:32,hirosima:33,yamaguti:34,
     tokusima:35,kagawa:36,ehime:37,kouti:38,
     hukuoka:39,saga:40,nagasaki:41,kumamoto:42,ooita:43,miyazaki:44,kagosima:45,
     okinawa:46
  }

   enum objective: { health: 0, appearance: 1, rack: 2, muscle: 3, tournament: 4 }
   enum frequency: { month: 0, two: 1, three: 2, five: 3}
   enum traning_style: { gym: 0, home: 1, personal: 2, other: 3}
   enum heart: { laxly: 0, moderate: 1, stoic: 2}
   enum history: { beginner: 0, months: 1, years: 2, old_hand: 3}

   # フォローをした、されたの関係
   has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
   has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
   # 一覧画面で使う
   has_many :followings, through: :relationships, source: :followed
   has_many :followers, through: :reverse_of_relationships, source: :follower

   # フォローしたときの処理
   def follow(customer_id)
     relationships.create(followed_id: customer_id)
   end
   # フォローを外すときの処理
   def unfollow(customer_id)
     relationships.find_by(followed_id: customer_id).destroy
   end
   # フォローしているか判定
   def following?(customer)
     followings.include?(customer)
   end
   
  # チャット機能のアソシエーション
   has_many :user_rooms, dependent: :destroy
   has_many :chat_rooms, through: :user_rooms
   has_many :chats, dependent: :destroy
   
  # 通知機能のアソシエーション
  # 紐付ける名前とクラス名が異なるため、明示的にクラス名とIDを指定して紐付ける
  # 自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy  
  # 相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy  
  
  # <-----フォロー通知----->
  def create_notification_follow!(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
