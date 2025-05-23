class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { regular: 1, admin: 5 }, default: :regular
  enum :gender, { male: 1, female: 3, neutral: 5 }

  validates :first_name, :last_name, :username, presence: true
  validates :biography, length: { maximum: 200 }
  validates :birth_date, comparison: { greater_than_or_equal_to: 100.years.ago.to_date }, allow_blank: true
  validates :birth_date, comparison: { less_than_or_equal_to: Date.current }, allow_blank: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/, message: I18n.t("error_messages.username_format_validation") }

  def full_name
    first_name.capitalize + " " + last_name.capitalize
  end

  def age
    return unless birth_date

    today = Date.current
    age = today.year - birth_date.year
    age -= 1 if today < birth_date + age.years
    age
  end

  def pronoun_label
    return unless gender

    I18n.t("user.pronoun.#{gender}")
  end
end
