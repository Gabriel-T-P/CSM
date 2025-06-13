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

  it 'successfully' do
    admin = create(:user, role: :admin)

    login_as admin
    visit admin_announcements_path
    click_on 'Add New Announcement'
    fill_in 'Title',	with: 'Test Title'
    fill_in 'Description',	with: 'Test Body'
    fill_in 'Start At',	with: Time.current
    fill_in 'End At',	with: 5.days.from_now
    click_on 'Save'

    expect(current_path).to eq admin_announcements_path
    expect(page).to have_content 'Announcement created with success'
    expect(page).to have_content 'Test Title'
    expect(page).to have_content I18n.l(Time.current, format: :short)
    expect(page).to have_content I18n.l(5.days.from_now, format: :short)
  end

  it 'and clicked in cancel' do
    admin = create(:user, role: :admin)

    login_as admin
    visit admin_announcements_path
    click_on 'Add New Announcement'
    fill_in 'Title',	with: 'Test Title'
    fill_in 'Description',	with: 'Test Body'
    fill_in 'Start At',	with: Time.current
    fill_in 'End At',	with: 5.days.from_now
    click_on 'Cancel'

    expect(current_path).to eq admin_announcements_path
    expect(page).not_to have_content 'Announcement created with success'
    expect(page).not_to have_content 'Test Title'
    expect(page).not_to have_content I18n.l(Time.current, format: :short)
    expect(page).not_to have_content I18n.l(5.days.from_now, format: :short)
  end

  it 'and view errors messages' do
    admin = create(:user, role: :admin)

    login_as admin
    visit admin_announcements_path
    click_on 'Add New Announcement'
    fill_in 'Title',	with: 'n'
    fill_in 'Description',	with: ' '
    fill_in 'Start At',	with: Time.current
    click_on 'Save'

    expect(current_path).to eq admin_announcements_path
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
    expect(page).to have_content "awd can't be blank"
  end
end
