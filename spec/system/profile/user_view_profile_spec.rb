require 'rails_helper'

describe 'User views profile page', type: :system do
  it 'by navbar' do
    user = create(:user, username: 'Test1')

    login_as user
    visit root_path
    within 'nav' do
      click_on 'Profile'
    end

    expect(current_path).to eq profile_path(username: user.username)
    expect(page).to have_content "Test1"
    expect(page).to have_content "Personal Informations"
  end

  it 'and have own profile informations' do
    user = create(:user, first_name: 'User', last_name: 'Test', email: 'user_1@email.com', location: 'Brazil', gender: :male, birth_date: 20.years.ago)
    create(:content, user: user)
    create(:content, user: user)

    login_as user
    visit profile_path(username: user.username)

    expect(page).to have_css('.avatar-profile')
    expect(page).to have_content 'Full Name: User Test'
    expect(page).to have_content 'Email: user_1@email.com'
    expect(page).to have_content 'Location: Brazil'
    expect(page).to have_content 'Age: 20 years'
    expect(page).to have_content 'Pronouns: he/him'
    expect(page).to have_content 'Member since 2025'
    expect(page).to have_content 'Contents Created'
  end

  it 'and its not authenticated' do
    user = create(:user, first_name: 'User', last_name: 'Test', email: 'user_1@email.com', location: 'Brazil', gender: :male, birth_date: 20.years.ago)

    visit profile_path(username: user.username)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'from another user with success' do
    user = create(:user, first_name: 'User', last_name: 'Test', email: 'user_1@email.com', location: 'Brazil', gender: :male, birth_date: 20.years.ago)
    other_user = create(:user)

    login_as other_user
    visit profile_path(username: user.username)

    expect(page).to have_content 'Full Name: User Test'
    expect(page).to have_content 'Email: user_1@email.com'
    expect(page).to have_content 'Location: Brazil'
    expect(page).to have_content 'Age: 20 years'
    expect(page).to have_content 'Pronouns: he/him'
  end

  it 'and views recent contents section' do
    user = create(:user)
    create(:content, user: user, title: 'Title Test 1')
    create(:content, user: user, title: 'Title Test 2')
    create(:content, title: 'Title Test 3')

    login_as user
    visit profile_path(username: user.username)

    expect(page).to have_content 'Title Test 1'
    expect(page).to have_content 'Title Test 2'
    expect(page).not_to have_content 'Title Test 3'
    expect(page).to have_link 'See All', href: user_contents_path(user)
  end

  it 'and another user view recent contents section' do
    user = create(:user)
    other_user = create(:user)
    create(:content, user: user, title: 'Title Test 1')
    create(:content, user: user, title: 'Title Test 2')
    create(:content, title: 'Title Test 3')

    login_as other_user
    visit profile_path(username: user.username)

    expect(page).to have_content 'Title Test 1'
    expect(page).to have_content 'Title Test 2'
    expect(page).not_to have_content 'Title Test 3'
    expect(page).not_to have_link 'See All', href: user_contents_path(user)
  end
end
