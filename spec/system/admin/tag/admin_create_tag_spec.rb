require 'rails_helper'

describe 'Admin creates tags', type: :system do
  it 'by navbar' do
    admin = create(:user, role: :admin)

    login_as admin
    visit root_path
    within 'nav' do
      click_on 'Tags'
    end

    expect(current_path).to eq admin_tags_path
    expect(page).to have_content "New Tag"
  end

  it 'successfully', js: true do
    admin = create(:user, role: :admin)

    login_as admin
    visit admin_tags_path
    fill_in 'Name',	with: 'Test Tag Name'
    click_on 'Create Tag'

    expect(current_path).to eq admin_tags_path
    expect(page).to have_content 'Tag created with success'
    expect(page).to have_content 'Test Tag Name'
  end

  it 'and fails for presence error', js: true do
    admin = create(:user, role: :admin)

    login_as admin
    visit admin_tags_path
    fill_in 'Name',	with: ' '
    click_on 'Create Tag'

    expect(current_path).to eq admin_tags_path
    expect(page).to have_content "Name can't be blank"
  end

  it 'and fails for uniqueness error', js: true do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Teste')

    login_as admin
    visit admin_tags_path
    fill_in 'Name',	with: 'Teste'
    click_on 'Create Tag'

    expect(current_path).to eq admin_tags_path
    expect(page).to have_content 'Name has already been taken'
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
