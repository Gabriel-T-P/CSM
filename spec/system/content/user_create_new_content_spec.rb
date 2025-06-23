require 'rails_helper'

describe 'User creates new content', type: :system do
  it 'by dashboard page' do
    user = create(:user)

    login_as user
    visit user_dashboard_path(user)

    expect(page).to have_link 'Upload'
  end

  it 'successfully' do
    user = create(:user, username: 'Username_1')
    create(:tag, name: 'Test 1')
    create(:tag, name: 'Test 2')

    login_as user
    visit user_dashboard_path(user)
    click_on 'Upload'
    fill_in 'Title', with: 'Test Title'
    select 'Private', from: 'Visibility'
    click_on 'Choose Tags'
    check 'Test 1'
    check 'Test 2'
    click_on 'Back'
    # attach_file(Rails.root.join("spec/support/files/test_avatar.png"))
    click_on 'Create Content'

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).to have_content 'Content upload with success'
    expect(page).to have_content 'Test Title'
    expect(page).to have_content 'Username_1'
  end
end
