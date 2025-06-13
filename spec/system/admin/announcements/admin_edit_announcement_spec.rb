require 'rails_helper'

describe 'Admin edits announcement', type: :system do
  it 'by announcement index page' do
    admin = create(:user, role: :admin)
    create(:announcement)

    login_as admin
    visit root_path
    click_on 'Announcements'
  end
  
end
