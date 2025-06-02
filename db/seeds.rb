# Admin User
puts 'Creating admin account'
master = User.create!(first_name: 'Master', last_name: 'Admin', username: 'Master', email: 'master@email.com', password: '12345678', password_confirmation: '12345678', role: :admin,
              biography: 'This account has the privileges of an Admin', birth_date: 20.years.ago, gender: :male, location: 'Canada')

default_avatar_path = Rails.root.join("app/assets/images/master_avatar.png")
master.avatar.attach(
  io: File.open(default_avatar_path),
  filename: "default_avatar.png",
  content_type: "image/png"
)

#Regular User
puts 'Creating regular account'
user = User.create!(first_name: 'User 1', last_name: 'User 1', username: 'User_1', email: 'user1@email.com', password: '12345678', password_confirmation: '12345678', role: :regular)

default_avatar_path = Rails.root.join("app/assets/images/default_avatar.png")
user.avatar.attach(
  io: File.open(default_avatar_path),
  filename: "default_avatar.png",
  content_type: "image/png"
)