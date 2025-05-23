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
    expect(page).to have_content "Test1"
    expect(page).to have_content "Personal Informations"
  end

  it 'and have profile informations' do
    user = create(:user, first_name: 'User', last_name: 'Test', email: 'user_1@email.com', location: 'Brazil', gender: :male, birth_date: 20.years.ago)

    login_as user
    visit profile_path(username: user.username)

    expect(page).to have_content 'Full Name: User Test'
    expect(page).to have_content 'Email: user_1@email.com'
    expect(page).to have_content 'Location: Brazil'
    expect(page).to have_content 'Age: 20 years'
    expect(page).to have_content 'Pronoun: he/him'
  end
end
