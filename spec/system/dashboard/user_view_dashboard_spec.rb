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

  it 'successfully' do
    user = create(:user)

    login_as user
    visit root_path
    find('.test-dashboard-btn').click

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).to have_content 'Recent Uploads'
    expect(page).to have_content 'My Collections'
    expect(page).to have_content 'My Friends'
  end
end
