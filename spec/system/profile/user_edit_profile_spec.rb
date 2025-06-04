require 'rails_helper'

describe 'User edits profile', type: :system do
  it 'by profile page' do
    user = create(:user, username: 'Test1')

    login_as user
    visit root_path
    within 'nav' do
      click_on 'Profile'
    end
    click_on 'Edit Profile'

    expect(current_path).to eq edit_user_registration_path
    expect(page).to have_content 'Edit your profile'
    expect(page).to have_content 'Private Information'
    expect(page).to have_content 'Public Information'
    expect(page).to have_content 'Danger'
  end

  it 'and its not authenticated' do
    visit edit_user_registration_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'successfully' do
    user = create(:user, first_name: 'User', last_name: 'God', email: 'user_1@email.com',
                  location: 'Brazil', gender: :male, birth_date: 20.years.ago, username: 'Test_God',
                  biography: 'This is a test bio', password: 'password123')

    login_as user
    visit edit_user_registration_path
    attach_file(Rails.root.join("spec/support/files/test_avatar.png"))
    fill_in 'Name', with: 'First Name'
    fill_in 'Last Name', with: 'Last Surname'
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '12345678'
    fill_in 'Location', with: 'United Estates'
    fill_in 'Biography', with: 'Another test bio'
    fill_in 'Username', with: 'Test_Username'
    fill_in 'Birth Date', with: 25.years.ago
    select 'she/her', from: 'Pronouns'
    fill_in 'Current Password', with: 'password123'
    click_on 'SAVE PROFILE'

    expect(current_path).to eq profile_path(username: 'Test_Username')
    expect(page).to have_content 'Your account has been updated successfully'
    expect(page).to have_css("img[src*='test_avatar.png']")
    expect(page).to have_content 'Test_Username'
    expect(page).to have_content 'Full Name: First Name Last Surname'
    expect(page).to have_content 'Location: United Estates'
    expect(page).to have_content 'Age: 25 years'
    expect(page).to have_content 'Pronouns: she/her'
    expect(page).to have_content 'Another test bio'
  end

  it 'with wrong fields entries' do
    user = create(:user, first_name: 'User', last_name: 'God', email: 'user_1@email.com',
                  location: 'Brazil', gender: :male, birth_date: 20.years.ago, username: 'Test_God',
                  biography: 'This is a test bio', password: 'password123')

    login_as user
    visit edit_user_registration_path
    fill_in 'Name', with: ' '
    fill_in 'Last Name', with: ' '
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '87654321'
    fill_in 'Username', with: 'Test Abra'
    fill_in 'Birth Date', with: 25.years.from_now
    fill_in 'Current Password', with: 'password123'
    click_on 'SAVE PROFILE'

    expect(page).to have_content '5 errors prohibited this user from being saved'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Last Name can't be blank"
    expect(page).to have_content "Birth Date must be less than or equal to #{Date.current}"
    expect(page).to have_content 'Username only permits letters, numbers and _'
    expect(page).to have_content "Password Confirmation doesn't match Password"
  end

  it 'without putting the current password' do
    user = create(:user, first_name: 'User', last_name: 'God', email: 'user_1@email.com',
                  location: 'Brazil', gender: :male, birth_date: 20.years.ago, username: 'Test_God',
                  biography: 'This is a test bio', password: 'password123')

    login_as user
    visit edit_user_registration_path
    fill_in 'Username', with: 'Test_Abra'
    fill_in 'Current Password', with: ' '
    click_on 'SAVE PROFILE'

    expect(page).to have_content '1 error prohibited this user from being saved'
    expect(page).to have_content "Current Password can't be blank"
  end

  it 'with wrong current password' do
    user = create(:user, first_name: 'User', last_name: 'God', email: 'user_1@email.com',
                  location: 'Brazil', gender: :male, birth_date: 20.years.ago, username: 'Test_God',
                  biography: 'This is a test bio', password: 'password123')

    login_as user
    visit edit_user_registration_path
    fill_in 'Username', with: 'Test_Abra'
    fill_in 'Current Password', with: '12345678'
    click_on 'SAVE PROFILE'

    expect(page).to have_content '1 error prohibited this user from being saved'
    expect(page).to have_content 'Current Password is invalid'
  end
end
