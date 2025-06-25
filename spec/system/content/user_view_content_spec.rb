require 'rails_helper'

describe 'User view detailed content', type: :system do
  it 'by dashboard' do
    user = create(:user, username: 'Test_User')
    content = create(:content, title: 'My Content', user: user)

    login_as user
    visit user_dashboard_path(user)

    expect(page).to have_selector("a[href='#{content_path(content)}']")
  end

  it 'successfully and its not authenticated' do
    user = create(:user)
    content = create(:content, title: 'My Content')

    visit content_path(content)

    expect(current_path).to eq content_path(content)
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'successfully and its authenticated' do
    
  end
end
