# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)






# =======管理者情報======

# Admin.create!(
#   email: 'a@a',
#   password: 'adminadmin',
#   )



# ========男性会員情報作成=========

# for n in 1..10
#   ActiveRecord::Base.transaction do
#       customer = Customer.new(
#         password: SecureRandom.urlsafe_base64,
#         email: "test_man#{n}@test.com",
#         name: "test男性#{n}",
#         introduction: "よろしくお願いします",
#         sex: 0,
#         history: n % 4,
#         active_area: n % 47,
#         objective: n % 5,
#         frequency: n % 4,
#         heart: n % 3,
#         traning_style: n % 4
#         )
#       customer.profile_image.attach(io: File.open("./db/fixtures/sample-man#{n}.jpg"), filename: "sample-man#{n}.jpg", content_type: 'image/jpg')
#       customer.save!
#   end
# end

# # ========女性会員情報作成=========

# for n in 1..10
#   ActiveRecord::Base.transaction do
#       customer = Customer.new(
#         password: SecureRandom.urlsafe_base64,
#         email: "test_wpman#{n}@test.com",
#         name: "test女性#{n}",
#         introduction: "よろしくお願いします",
#         sex: 1,
#         history: n % 4,
#         active_area: n % 47,
#         objective: n % 5,
#         frequency: n % 4,
#         heart: n % 3,
#         traning_style: n % 4
#         )
#       customer.profile_image.attach(io: File.open("./db/fixtures/sample-woman#{n}.jpg"), filename: "sample-woman#{n}.jpg", content_type: 'image/jpg')
#       customer.save!
#   end
# end

      # image.attach(io: File.open("./db/fixtures/sample-post1.jpg")),
      #             filename: "sample-post1.jpg", content_type: 'image/jpg')
      # )
ActiveRecord::Base.transaction do
  Customer.all.each_with_index do |customer, i|
    post = customer.posts.new(
      title: 'タイトル',
      caption: 'テキストテキストテキストテキストテキストテキストテキストテキストテキスト'
                  )
    post.image.attach(io: File.open(Rails.root.join("./db/fixtures/sample-post#{i}.jpg")),
                   filename: 'sample-post1.jpg')
    break if i == 19
      post.save!
  end
end


