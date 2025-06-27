require 'rails_helper'

describe 'User view own dashboard', type: :system do
  it 'by navbar' do
    user = create(:user)

    login_as user
    visit root_path

    within 'nav' do
      expect(page).to have_css '.test-dashboard-btn'
    end
  end

  it 'after successfully login' do
    user = create(:user, email: 'email@test.com', password: 'password123')

    visit new_user_session_path
    fill_in 'Email',	with: 'email@test.com'
    fill_in 'Password', with: 'password123'
    click_on 'Log in'

    expect(current_path).to eq user_dashboard_path(user)
  end

  it 'successfully' do
    user = create(:user)
    content = create(:content, title: 'Content Test', user: user)

    login_as user
    visit root_path
    find('.test-dashboard-btn').click

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).to have_content 'Recent Uploads'
    expect(page).to have_content 'Content Test'
    expect(page).to have_content 'My Collections'
    expect(page).to have_content 'My Friends'
  end

  it 'and its not authenticated' do
    user = create(:user)

    visit user_dashboard_path(user)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'and its not the owner of the dashboard' do
    user = create(:user)
    other_user = create(:user)

    login_as other_user
    visit user_dashboard_path(user)

    expect(current_path).to eq root_path
    expect(page).to have_content 'You can not access this page'
  end

  it 'and has no content created by the user' do
    user = create(:user)

    login_as user
    visit root_path
    find('.test-dashboard-btn').click

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).to have_content 'Recent Uploads'
    expect(page).to have_content 'No content found yet'
  end
end
