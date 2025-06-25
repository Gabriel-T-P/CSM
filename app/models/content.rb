class Content < ApplicationRecord
  has_rich_text :body
  has_one_attached :cover
  belongs_to :user
  has_many :content_tags, dependent: :destroy
  has_many :tags, through: :content_tags

  before_create :generate_unique_code

  enum :visibility, { visible_to_all: 1, only_me: 5, unlisted: 9 }, default: :only_me

  validates :title, :body, presence: true
  validates :title, length: { maximum: 50 }

  def self.visibility_options
    {
      only_me: I18n.t("content.visibility.only_me"),
      visible_to_all: I18n.t("content.visibility.visible_to_all"),
      unlisted: I18n.t("content.visibility.unlisted")
    }.map { |key, label| [ label, key ] }
  end

  def to_param
    code
  end

  private

  def generate_unique_code
    loop do
      self.code = SecureRandom.alphanumeric(12)
      break unless Content.exists?(code: code)
    end
  end
end
