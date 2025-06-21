require 'rails_helper'

RSpec.describe Content, type: :model do
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
