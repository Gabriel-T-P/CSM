class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
