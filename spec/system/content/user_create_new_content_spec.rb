require 'rails_helper'

describe 'User creates new content', type: :system do
  it 'by dashboard page' do
    user = create(:user)

    login_as user
    visit user_dashboard_path(user)

    expect(page).to have_link 'Upload'
  end

  it 'successfully' do
    user = create(:user)

    login_as user
    visit user_dashboard_path(user)
    click_on 'Upload'
    fill_in 'Title', with: 'Test Title'
    find('input#content_body', visible: false).set('Test Text in rich text')
    select 'Private', from: 'Visibility'
  end
end
