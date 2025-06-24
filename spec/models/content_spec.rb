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
end
