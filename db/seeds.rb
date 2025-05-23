# Admin User
puts 'Creating admin account'
User.create!(first_name: 'Master', last_name: 'Admin', username: 'Master', email: 'master@email.com', password: '12345678', password_confirmation: '12345678', role: :admin,
              biography: 'This account has the privileges of an Admin', birth_date: 20.years.ago, gender: :male, location: 'Canada')


#Regular User
puts 'Creating regular account'
User.create!(first_name: 'User 1', last_name: 'User 1', username: 'User_1', email: 'user1@email.com', password: '12345678', password_confirmation: '12345678', role: :regular)