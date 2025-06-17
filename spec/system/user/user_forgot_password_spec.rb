require 'rails_helper'

describe 'User access forgots password page', type: :system do
  it 'by Log In page' do
    visit root_path
    within 'nav' do
      click_on 'LOG IN'
    end
    click_on 'Forgot your password?'

    expect(current_path).to eq new_user_password_path
    expect(page).to have_content 'Forgot your password?'
    expect(page).to have_field 'Email'
    expect(page).to have_button 'Send me reset password instructions'
  end

  it 'but its already logged in' do
    user = create(:user)

    login_as user
    visit new_user_password_path

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).to have_content 'You are already signed in'
  end
end
