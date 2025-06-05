require 'rails_helper'

describe 'Admin deletes tags', type: :system do
  it 'by navbar' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Test Tag')

    login_as admin
    visit root_path
    within 'nav' do
      click_on 'Tags'
    end

    expect(current_path).to eq admin_tags_path
    expect(page).to have_content 'Test Tag'
    expect(page).to have_css('.test-delete-btn')
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

  it 'successfully' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'First Name')

    login_as admin
    visit admin_tags_path
    find('.test-delete-btn').click

    expect(current_path).to eq admin_tags_path
    expect(page).not_to have_content 'First Name'
  end
end
