require 'rails_helper'

describe 'User creates account', type: :system do
  it 'by navbar button' do
    visit root_path
    within 'nav' do
      click_on 'LOG IN'
    end
    click_on 'Sign up'

    expect(current_path).to eq new_user_registration_path
    expect(page).to have_content 'Sign up'
  end

  it 'but its already logged in' do
    user = create(:user)

    login_as user
    visit new_user_registration_path

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).to have_content 'You are already signed in'
  end

  it 'successfully' do
    fake_image_path = Rails.root.join("spec/support/files/test_avatar.png")
    fake_image_data = File.read(fake_image_path)
    fake_response = instance_double(
      Faraday::Response,
      status: 200,
      success?: true,
      body: fake_image_data,
      headers: { 'content-type' => 'image/png' }
    )
    allow(Faraday).to receive(:get).and_return(fake_response)

    visit new_user_registration_path
    fill_in 'Name',	with: 'Test Name'
    fill_in 'Last Name',	with: 'Test Last Name'
    fill_in 'Username',	with: 'Username'
    fill_in 'Email',	with: 'email@test.com'
    fill_in 'Password',	with: '12345test'
    fill_in 'Password Confirmation', with: '12345test'
    click_on 'Register'

    expect(current_path).to eq user_dashboard_path(User.last)
    expect(page).to have_content 'Welcome! You have signed up successfully'
    within 'nav' do
      expect(page).not_to have_link 'Sign up'
      expect(page).to have_content 'USERNAME'
      expect(page).to have_button 'Log out'
    end
    user = User.last
    expect(user.avatar).to be_attached
  end

  it 'with error on Avatar API' do
    fake_response = instance_double(
      Faraday::Response,
      status: 502,
      success?: false,
      body: 'Error on request for Avatar'
    )
    allow(Faraday).to receive(:get).and_return(fake_response)

    visit new_user_registration_path
    fill_in 'Name',	with: 'Test Name'
    fill_in 'Last Name',	with: 'Test Last Name'
    fill_in 'Username',	with: 'Username'
    fill_in 'Email',	with: 'email@test.com'
    fill_in 'Password',	with: '12345test'
    fill_in 'Password Confirmation', with: '12345test'
    click_on 'Register'

    expect(current_path).to eq user_dashboard_path(User.last)
    expect(page).to have_content 'Welcome! You have signed up successfully'
    within 'nav' do
      expect(page).not_to have_link 'Sign up'
      expect(page).to have_content 'USERNAME'
      expect(page).to have_button 'Log out'
    end
    user = User.last
    expect(user.avatar).to be_attached
  end

  it 'and view presence errors messages' do
    visit new_user_registration_path
    fill_in 'Name',	with: ' '
    fill_in 'Last Name',	with: ' '
    fill_in 'Username',	with: ' '
    fill_in 'Email',	with: ' '
    fill_in 'Password',	with: ' '
    fill_in 'Password Confirmation', with: ' '
    click_on 'Register'

    expect(page).to have_content '6 errors prohibited this user from being saved'
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Last Name can't be blank"
    expect(page).to have_content "Username can't be blank"
    expect(page).to have_content "Username only permits letters, numbers and _"
  end

  it 'and view uniqueness email error message' do
    user = create(:user, email: 'email@test.com')

    visit new_user_registration_path
    fill_in 'Name',	with: 'Test Name'
    fill_in 'Last Name',	with: 'Test Last Name'
    fill_in 'Username',	with: 'Test_Username'
    fill_in 'Email',	with: 'email@test.com'
    fill_in 'Password',	with: '12345test'
    fill_in 'Password Confirmation', with: '12345test'
    click_on 'Register'

    expect(page).to have_content '1 error prohibited this user from being saved'
    expect(page).to have_content "Email has already been taken"
  end
end
