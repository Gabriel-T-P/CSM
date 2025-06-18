require 'rails_helper'

describe 'User views announcements', type: :system do
  it 'successfully by dashboard' do
    user = create(:user)
    create(:announcement, title: 'Active', body: 'should appear', start_at: 2.days.ago)
    create(:announcement, title: 'In Future', body: 'should not appear', start_at: 2.days.from_now)

    login_as user
    visit user_dashboard_path(user)

    expect(page).to have_content('Active')
    expect(page).to have_content('should appear')
    expect(page).to have_content('Posted 2 days ago')
    expect(page).not_to have_content('In Future')
    expect(page).not_to have_content('should not appear')
  end
end
