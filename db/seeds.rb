# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Admin User
User.create!(first_name: 'Master', last_name: 'Admin', username: 'Master', email: 'master@email.com', password: '12345678', password_confirmation: '12345678', role: :admin)

#Regular User
User.create!(first_name: 'User 1', last_name: 'User 1', username: 'User_1', email: 'user1@email.com', password: '12345678', password_confirmation: '12345678', role: :regular)