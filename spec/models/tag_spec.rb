require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '#valid?' do
    subject { create(:tag) } 
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
