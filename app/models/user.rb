class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { regular: 1, admin: 5 }, default: :regular
  enum :gender, { masculine: 1, feminine: 3 }

  validates :first_name, :last_name, :username, presence: true
  validates :biography, length: { maximum: 200 }
  validates :birth_date, comparison: { greater_than_or_equal_to: 100.years.ago.to_date }, allow_blank: true
  validates :birth_date, comparison: { less_than_or_equal_to: Date.current }, allow_blank: true
  validates :username, uniqueness: { case_sensitive: false }
end
