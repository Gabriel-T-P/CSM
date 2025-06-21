class Tag < ApplicationRecord
  has_many :content_tags
  has_many :contents, through: :content_tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  private

  def self.ordered(order)
    case order
    when "name_asc"
      order(name: :asc)
    when "name_desc"
      order(name: :desc)
    when "created_desc"
      order(created_at: :desc)
    else
      order(created_at: :asc)
    end
  end
end
