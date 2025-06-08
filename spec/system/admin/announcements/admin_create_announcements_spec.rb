require 'rails_helper'

describe 'Admin creates announcements', type: :system do
  it 'by admin navbar' do
    admin = create(:user, role: :admin)

    login_as admin
    visit root_path
    within 'nav' do
      click_on 'Announcements'
    end

    expect(current_path).to eq admin_announcements_path
    expect(page).to have_content 'New Announcement'
    expect(page).to have_css('.test-new-announcement-btn')
  end

  it 'and its not authenticated' do
    visit admin_announcements_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'and its a regular user' do
    user = create(:user, role: :regular)

    login_as user
    visit admin_announcements_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'You can not access this page'
  end
end
