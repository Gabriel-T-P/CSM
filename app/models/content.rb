class Content < ApplicationRecord
  has_rich_text :body
  belongs_to :user
  has_many :content_tags
  has_many :tags, through: :content_tags

  enum :visibility, { visible_to_all: 1, only_me: 5, unlisted: 9 }, default: :only_me
end
