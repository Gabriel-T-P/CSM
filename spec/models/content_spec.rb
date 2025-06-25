require 'rails_helper'

RSpec.describe Content, type: :model do
  describe "#valid?" do
    context "presence" do
      subject { create(:content) }
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:body) }
    end

    context 'default' do
      it 'new content visibility default for private' do
        content = Content.new(title: 'Title Test', body: 'Body Test')

        expect(content.visibility).to eq 'only_me'
      end
    end

    context 'length' do
      it { should validate_length_of(:title).is_at_most(50) }
    end

    context 'extras' do
      subject { create(:content) }
      it { should define_enum_for(:visibility).with_values(visible_to_all: 1, only_me: 5, unlisted: 9) }
      it { should have_one_attached(:cover) }
    end
  end

  describe '.visibility_options' do
    it 'returns an array of visibility options with translated labels and symbols' do
      expect(Content.visibility_options).to eq([
        ["Private", :only_me],
        ["Public", :visible_to_all],
        ["Unlisted", :unlisted]
      ])
    end
  end

  describe '.generate_unique_code' do
    it 'generates a unique alphanumeric code on create' do
      content = create(:content)

      expect(content.code).to be_present
      expect(content.code).to match(/\A[a-zA-Z0-9]{12}\z/)
    end

    it 'generates different codes for different contents' do
      user = create(:user)
      content1 = create(:content, title: "Test 1", visibility: "only_me", user: user)
      content2 = create(:content, title: "Test 2", visibility: "only_me", user: user)

      expect(content1.code).not_to eq(content2.code)
    end
  end
end
