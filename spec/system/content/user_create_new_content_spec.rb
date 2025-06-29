require 'rails_helper'
include ActionView::Helpers::DateHelper

describe 'User creates new content', type: :system do
  it 'by dashboard page' do
    user = create(:user)

    login_as user
    visit user_dashboard_path(user)

    expect(page).to have_link 'Upload'
  end

  it 'and its not authenticated' do
    user = create(:user)

    visit new_user_content_path(user)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'and its not the owner of the dashboard' do
    user = create(:user)
    other_user = create(:user)

    login_as other_user
    visit new_user_content_path(user)

    expect(current_path).to eq user_dashboard_path(other_user)
    expect(page).to have_content 'You can not access this page'
  end

  it 'and has no tags created for form' do
    user = create(:user, username: 'Username_1')

    login_as user
    visit new_user_content_path(user)

    expect(page).to have_content 'There are no tags registered yet'
  end

  xit 'successfully' do
    user = create(:user, username: 'Username_1')
    create(:tag, name: 'Test 1')
    create(:tag, name: 'Test 2')

    login_as user
    visit new_user_content_path(user)
    fill_in 'Title', with: 'Test Title'
    find_css_path = "trix-editor[input]"
    find(find_css_path).click.set("Este é o texto do meu Action Text.")
    select 'Private', from: 'Visibility'
    click_on 'Show Tags'
    check 'Test 1'
    check 'Test 2'
    attach_file(Rails.root.join("spec/support/files/test_avatar.png"))
    click_on 'Create Content'

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).to have_content 'Content upload with success'
    expect(page).to have_content 'Test Title'
    expect(page).to have_content 'Username_1'
    expect(page).to have_content time_ago_in_words(Content.first.created_at)
  end

  it 'and view errors messages' do
    user = create(:user, username: 'Username_1')
    create(:tag, name: 'Test 1')
    create(:tag, name: 'Test 2')

    login_as user
    visit new_user_content_path(user)
    fill_in 'Title', with: ' '
    find(:xpath, "//\*[@id='content_body']", visible: false).set(' ')
    click_on 'Create Content'

    expect(page).to have_content 'Failed to upload your content'
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Content can't be blank"
  end

  it 'and clicks on cancel' do
    user = create(:user, username: 'Username_1')
    create(:tag, name: 'Test 1')
    create(:tag, name: 'Test 2')

    login_as user
    visit user_dashboard_path(user)
    click_on 'Upload'
    fill_in 'Title', with: 'Test Title'
    select 'Private', from: 'Visibility'
    click_on 'Show Tags'
    check 'Test 1'
    check 'Test 2'
    attach_file(Rails.root.join("spec/support/files/test_avatar.png"))
    click_on 'Cancel'

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).not_to have_content 'Content upload with success'
    expect(page).not_to have_content 'Test Title'
    expect(page).not_to have_content 'Username_1'
  end
end
