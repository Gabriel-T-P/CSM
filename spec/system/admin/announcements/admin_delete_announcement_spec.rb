require 'rails_helper'

describe 'Admin deletes tag', type: :system do
  it 'by announcement index page' do
    admin = create(:user, role: :admin)
    announcement = create(:announcement, title: 'Test Announcement')

    login_as admin
    visit root_path
    click_on 'Announcements'
    find('.test-dropdown-table-btn').click

    expect(page).to have_content 'Test Announcement'
    expect(page).to have_button 'Delete'
  end

  it 'and its not authenticated' do
    announcement = create(:announcement)

    visit edit_admin_announcement_path(announcement)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'and its a regular user' do
    user = create(:user, role: :regular)
    announcement = create(:announcement)

    login_as user
    visit edit_admin_announcement_path(announcement)

    expect(current_path).to eq root_path
    expect(page).to have_content 'You can not access this page'
  end
  
  it 'successfully' do
    admin = create(:user, role: :admin)
    announcement = create(:announcement, title: 'Test Title', start_at: Time.current, end_at: 5.days.from_now)

    login_as admin
    visit admin_announcements_path
    find('.test-dropdown-table-btn').click
    click_on 'Delete'

    expect(current_path).to eq admin_announcements_path
    expect(page).to have_content 'Announcement deleted with success'
    expect(page).not_to have_content 'Test Title'
    expect(page).not_to have_content I18n.l(Time.current, format: :short)
    expect(page).not_to have_content I18n.l(5.days.from_now, format: :short)
  end
end
