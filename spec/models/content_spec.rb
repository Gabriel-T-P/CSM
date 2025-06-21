require 'rails_helper'

RSpec.describe Content, type: :model do
  describe '.visibility_label' do
    it 'returns visibility name according to visibility attribute (private)' do
      content = create(:content, visibility: :only_me)

      result = content.visibility_label

      expect(result).to eq 'Private'
    end

    it 'returns visibility name according to visibility attribute (public)' do
      content = create(:content, visibility: :visible_to_all)

      result = content.visibility_label

      expect(result).to eq 'Public'
    end

    it 'returns visibility name according to visibility attribute (unlisted)' do
      content = create(:content, visibility: :unlisted)

      result = content.visibility_label

      expect(result).to eq 'Unlisted'
    end
  end
end
