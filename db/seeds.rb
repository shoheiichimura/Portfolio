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
#   customer = Customer.create!(
#     password: SecureRandom.urlsafe_base64,
#     email: "test#{n}@test.com",
#     name: "test男性#{n}",
#     introduction: "よろしくお願いします",
#     sex: 0,
#     history: n % 4,
#     active_area: n % 47,
#     objective: n % 5,
#     frequency: n % 4,
#     heart: n % 3,
#     traning_style: n % 4
#     )
#   customer.profile_image.attach(io: File.open("./app/assets/images/man/man#{n}.jpg"), filename: "man#{n}.jpg", content_type: 'image/jpg')
# end

# ========女性会員情報作成=========
# for n in 1..10
#   customer = Customer.create!(
#     password: SecureRandom.urlsafe_base64,
#     email: "testwoman#{n}@test.com",
#     name: "test女性#{n}",
#     introduction: "よろしくお願いします",
#     sex: 1,
#     history: n % 4,
#     active_area: n % 47,
#     objective: n % 5,
#     frequency: n % 4,
#     heart: n % 3,
#     traning_style: n % 4
#     )
#   customer.profile_image.attach(io: File.open("./app/assets/images/woman/woman#{n}.jpg"), filename: "woman#{n}.jpg", content_type: 'image/jpg')
# end

# for n in 1..17
# Customer.all.each do |customer|
#   customer.posts.create!(
#     title: 'タイトル',
#     caption: 'テキストテキストテキストテキストテキストテキストテキストテキストテキスト',
#   )
# end
# # image.attach(io: File.open("./app/fixtures/sample-post#{n}.jpg"), filename: "sample-post#{n}.jpg", content_type: 'image/jpg')
# end

