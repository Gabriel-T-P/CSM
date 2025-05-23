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
      it { should allow_value('test_user').for(:username) }
      it { should_not allow_value('$test_user').for(:username) }
      it { should_not allow_value('%test_user').for(:username) }
      it { should_not allow_value('&test_user').for(:username) }
      it { should define_enum_for(:role).with_values(regular: 1, admin: 5) }
      it { should define_enum_for(:gender).with_values(male: 1, female: 3, neutral: 5) }
    end
  end

  describe '.full_name' do
    it 'returns first name and last name' do
      user = create(:user, first_name: 'Test', last_name: 'Last')

      result = user.full_name

      expect(result).to eq 'Test Last'
    end

    it 'return full name capitalized' do
      user = create(:user, first_name: 'test', last_name: 'last')

      result = user.full_name

      expect(result).to eq 'Test Last'
    end
  end

  describe '.age' do
    it 'returns user age based on birth date' do
      user = create(:user, first_name: 'Test', last_name: 'Last', birth_date: 10.years.ago)

      result = user.age

      expect(result).to eq 10
    end

    it 'returns age only if birth date is present' do
      user = create(:user, first_name: 'Test', last_name: 'Last')

      result = user.age

      expect(result).to eq nil
    end
  end

  describe '.pronoun_label' do
    it 'returns pronoun according to gender of user' do
      user = create(:user, gender: :male)

      result = user.pronoun_label

      expect(result).to eq 'he/him'
    end

    it 'returns age only if birth date is present' do
      user = create(:user, first_name: 'Test', last_name: 'Last')

      result = user.pronoun_label

      expect(result).to eq nil
    end
  end
end
