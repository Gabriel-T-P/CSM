require 'rails_helper'

RSpec.describe Announcement, type: :model do
  describe "#valid?" do
    context "presence" do
      subject { create(:announcement) }
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:body) }
    end

    context 'length' do
      it { should validate_length_of(:title).is_at_most(70) }
      it { should validate_length_of(:body).is_at_most(600) }
    end
  end

  describe '.validate_date_range' do
    context 'when both start_at and end_at are nil' do
      it 'is valid' do
        announcement = build(:announcement, start_at: nil, end_at: nil)

        expect(announcement).to be_valid
      end
    end

    context 'when both start_at and end_at are present' do
      it 'is valid' do
        announcement = build(:announcement,
          start_at: Time.current,
          end_at: 2.days.from_now
        )

        expect(announcement).to be_valid
      end

      it 'is invalid with start_at after end_at' do
        announcement = build(:announcement,
          start_at: 2.days.from_now,
          end_at: Time.current
        )

        expect(announcement).to be_invalid
        expect(announcement.errors[:base]).to include("Start date can't be after End date")
      end

      it 'is invalid with start_at equal end_at' do
        time = Time.current
        announcement = build(:announcement, start_at: time, end_at: time)

        expect(announcement).to be_invalid
        expect(announcement.errors[:base]).to include("Start date can't be after End date")
      end
    end

    context 'when only start_at is present' do
      it 'is invalid' do
        announcement = build(:announcement,
          start_at: Time.current,
          end_at: nil
        )

        expect(announcement).to be_invalid
        expect(announcement.errors[:base]).to include("Start and End dates must both be present or both be absent")
      end
    end

    context 'when only end_at is present' do
      it 'is invalid' do
        announcement = build(:announcement,
          start_at: nil,
          end_at: 2.days.from_now
        )

        expect(announcement).to be_invalid
        expect(announcement.errors[:base]).to include("Start and End dates must both be present or both be absent")
      end
    end
  end
end
