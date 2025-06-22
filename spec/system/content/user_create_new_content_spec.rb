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
    create(:tag, name: 'Test 1')
    create(:tag, name: 'Test 2')

    login_as user
    visit user_dashboard_path(user)
    click_on 'Upload'
    fill_in 'Title', with: 'Test Title'
    find(:css, "#content_body", visible: false).set('Test Text in rich text')
    select 'Private', from: 'Visibility'
    click_on 'Choose Tags'
    check 'Test 1'
    check 'Test 2'
    click_on 'Confirm'
    attach_file(Rails.root.join("spec/support/files/test_avatar.png"))
    click_on 'Create Content'

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).to have_content 
  end
end
