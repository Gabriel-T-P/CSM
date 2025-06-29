require 'rails_helper'

describe 'User delete content', type: :system do
  it 'by edit page' do
    user = create(:user)
    content = create(:content, title: 'Test Content', user: user)

    login_as user
    visit user_dashboard_path(user)
    click_on 'Test Content'
    click_on 'Edit Content'

    expect(page).to have_button 'DELETE'
  end

  it 'by content index page' do
    user = create(:user)
    create(:content, user: user)

    login_as user
    visit user_contents_path(user)

    expect(page).to have_button 'Delete'
  end

  it 'successfully' do
    user = create(:user)
    content = create(:content, title: 'Title Test', user: user)

    login_as user
    visit content_path(content)
    click_on 'Edit Content'
    click_on 'DELETE'

    expect(current_path).to eq user_contents_path(user)
    expect(page).to have_content 'Content was successfully deleted'
    expect(page).not_to have_content 'Title Test'
  end
end
