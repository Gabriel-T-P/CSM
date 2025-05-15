require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    context "presence" do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
    end

    context 'uniqueness' do
      subject { create(:user) }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end

    context 'length' do
      it { should validate_length_of(:password).is_at_least(8) }
    end

    context 'format' do
      subject { create(:user) } 
      it { should allow_value('user@example.com').for(:email) }
      it { should_not allow_value('userexample').for(:email) }
    end
  end
end
