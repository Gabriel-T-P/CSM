class Content < ApplicationRecord
  has_rich_text :body
  belongs_to :user

  enum :visibility, { visible_to_all: 1, only_me: 5, unlisted: 9 }, default: :only_me
end
