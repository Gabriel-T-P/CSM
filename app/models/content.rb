class Content < ApplicationRecord
  has_rich_text :body
  belongs_to :user
  has_many :content_tags
  has_many :tags, through: :content_tags

  enum :visibility, { visible_to_all: 1, only_me: 5, unlisted: 9 }, default: :only_me

  def self.visibility_options
    {
      only_me: I18n.t("content.visibility.only_me"),
      visible_to_all: I18n.t("content.visibility.visible_to_all"),
      unlisted: I18n.t("content.visibility.unlisted")
    }.map { |key, label| [label, key] }
  end
end
