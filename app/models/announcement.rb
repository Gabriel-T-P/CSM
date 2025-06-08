class Announcement < ApplicationRecord
  validates :title, :body, presence: true
  validates :title, length: { maximum: 70 }
  validates :body, length: { maximum: 600 }
  validate :validate_date_range

  private

  def validate_date_range
    if start_at.blank? ^ end_at.blank?
      errors.add(:base, :date_present_or_absent)
    elsif start_at.present? && end_at.present? && start_at >= end_at
      errors.add(:base, :invalid_date_range)
    end
  end
end
