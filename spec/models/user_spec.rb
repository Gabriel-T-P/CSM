require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    context "presence" do
      subject { create(:user) }
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
    end

    context 'default' do
      it 'new user role default for regular' do
        user = User.new(first_name: 'abc', last_name: 'abc', username: 'abc', email: 'abc@email.com', password: '12345678', password_confirmation: '12345678')

        expect(user.role).to eq 'regular'
      end
    end

    context 'uniqueness' do
      subject { create(:user) }
      it { should validate_uniqueness_of(:email).case_insensitive }
      it { should validate_uniqueness_of(:username).case_insensitive }
    end

    context 'comparison' do
      it { should validate_comparison_of(:birth_date).is_less_than_or_equal_to(Date.current) }
      it { should validate_comparison_of(:birth_date).is_greater_than_or_equal_to(100.years.ago.to_date) }
    end

    context 'length' do
      it { should validate_length_of(:password).is_at_least(8) }
      it { should validate_length_of(:biography).is_at_most(200) }
    end

    context 'format' do
      subject { create(:user) }
      it { should allow_value('user@example.com').for(:email) }
      it { should_not allow_value('userexample').for(:email) }
      it { should define_enum_for(:role).with_values(regular: 1, admin: 5) }
      it { should define_enum_for(:gender).with_values(masculine: 1, feminine: 3) }
    end
  end
end
