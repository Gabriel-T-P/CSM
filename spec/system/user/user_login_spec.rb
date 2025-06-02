require 'rails_helper'

describe 'User login account', type: :system do
  it 'by navbar' do
    visit root_path
    within 'nav' do
      click_on 'LOG IN'
    end

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Log in'
  end

  it 'but its already logged in' do
    user = create(:user)

    login_as user
    visit new_user_session_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'You are already signed in'
  end

  it 'successfully' do
    user = create(:user, username: 'Testing', email: 'email@test.com', password: '12345678', password_confirmation: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'email@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(current_path).to eq root_path
    within 'nav' do
      expect(page).to have_content 'TESTING'
      expect(page).to have_button 'Log out'
      expect(page).not_to have_link 'LOG IN'
      expect(page).to have_css('.avatar-profile')
    end
  end

  it 'and view errors messages' do
    user = create(:user, username: 'Testing', email: 'email@test.com', password: '12345678', password_confirmation: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
  end
end
