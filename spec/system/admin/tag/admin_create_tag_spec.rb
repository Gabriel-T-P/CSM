require 'rails_helper'

describe 'Admin creates tags', type: :system do
  xit 'by navbar' do
    
  end
  
  it 'successfully' do
    admin = create(:user, role: :admin)

    login_as admin
    visit admin_tags_path
    fill_in 'Name',	with: 'Test Tag Name'
    click_on 'Create Tag'
    
    expect(current_path).to eq admin_tags_path
    expect(page).to have_content 'Tag created with success'
    expect(page).to have_content 'Test Tag Name'
  end

  it 'and its not authenticated' do
    visit admin_tags_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'and its a regular user' do
    user = create(:user, role: :regular)

    login_as user
    visit admin_tags_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'You can not access this page'
  end
end
