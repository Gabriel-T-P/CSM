require 'rails_helper'

describe 'User view detailed content', type: :system do
  it 'by dashboard' do
    user = create(:user, username: 'Test_User')
    create(:content, title: 'My Content')

    login_as user
    visit user_dashboard_path(user)

    expect(page).to have_link 'My Content'
  end

  it 'and its not authenticated' do
    user = create(:user)
    content = create(:content, title: 'My Content')

    visit user_content_path(user, content)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'successfully' do
    
  end
end
