require 'rails_helper'

describe 'User edit own content' do
  it 'by content show page' do
    user = create(:user)
    content = create(:content, user: user)

    login_as user
    visit content_path(content)

    expect(page).to have_link 'Edit Content'
    expect(page).not_to have_link 'Follow'
  end
end
