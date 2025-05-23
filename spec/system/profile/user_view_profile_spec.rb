require 'rails_helper'

describe 'User views own profile page', type: :system do
  it 'by navbar' do
    user = create(:user, username: 'Test1')

    login_as user
    visit root_path
    within 'nav' do
      click_on 'Profile'
    end

    expect(current_path).to eq profile_path(username: user.username)
    expect(page).to have_content "Test1's Profile"
  end

  it 'and have profile informations' do
    user = create(:user)

    login_as user
    visit profile_path(username: user.username)

    expect(page).to have_content ''
  end
end
