require 'rails_helper'

describe 'User creates account', type: :system do
  it 'by navbar button' do
    visit root_path
    within 'nav' do
      click_on 'Sign up'
    end

    expect(current_path).to eq new_user_registration_path
    expect(page).to have_content 'Sign up'
  end

  it 'successfully' do
    visit new_user_registration_path
    fill_in 'Name',	with: 'Test Name'
    fill_in 'Last Name',	with: 'Test Last Name'
    fill_in 'Username',	with: 'Test Username'
    fill_in 'Email',	with: 'email@test.com'
    fill_in 'Password',	with: '123test'
    fill_in 'Password Confirmation', with: '123test'
    click_on 'Register'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Welcome! You have signed up successfully'
    within 'nav' do
      expect(page).to have_button 'Log out'
      expect(page).not_to have_link 'Sign up'
      expect(page).to have_content 'Test Username'
    end
  end
end
