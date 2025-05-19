class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { regular: 1, admin: 5 }, default: :regular

  validates :first_name, :last_name, :username, :role, presence: true
  validates :username, uniqueness: { case_sensitive: false }
end
