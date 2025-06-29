require 'rails_helper'

describe 'User edit own content', type: :system do
  context 'navigating' do
    it 'by content show page' do
      user = create(:user)
      content = create(:content, user: user)

      login_as user
      visit content_path(content)

      expect(page).to have_link 'Edit Content', href: edit_user_content_path(user, content)
      expect(page).not_to have_link 'Follow'
    end

    it 'by content show page and its not the owner' do
      user = create(:user)
      content = create(:content)

      login_as user
      visit content_path(content)

      expect(page).not_to have_link 'Edit Content', href: edit_user_content_path(user, content)
      expect(page).to have_link 'Follow'
    end

    it 'by content index page' do
      user = create(:user)
      content = create(:content, user: user)

      login_as user
      visit user_contents_path(user)

      expect(page).to have_link 'Edit', href: edit_user_content_path(user, content)
    end
  end

  it 'and its not authenticated' do
    user = create(:user)
    content = create(:content, user: user)

    visit edit_user_content_path(user, content)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  it 'and its not the owner of the content' do
    user = create(:user)
    content = create(:content)

    login_as user
    visit edit_user_content_path(user, content)

    expect(current_path).to eq user_dashboard_path(user)
    expect(page).to have_content 'You can not access this page'
  end

  it 'and has no tags created for form' do
    user = create(:user)
    content = create(:content, user: user)

    login_as user
    visit edit_user_content_path(user, content)

    expect(page).to have_content 'There are no tags registered yet'
  end

  it 'sucessfully' do
    user = create(:user)
    tag = create(:tag, name: 'Tag 1')
    content = create(:content, title: 'Test Title', body: 'Test Body', visibility: :only_me, tags: [ tag ], user: user)

    login_as user
    visit edit_user_content_path(user, content)
    fill_in 'Title', with: 'Another Title'
    find_css_path = "trix-editor[input]"
    find(find_css_path).click.set("Este é o texto do meu Action Text.")
    select 'Public', from: 'Visibility'
    click_on 'Show Tags'
    uncheck 'Tag 1'
    attach_file(Rails.root.join("spec/support/files/test_avatar.png"))
    click_on 'Update Content'

    expect(current_path).to eq content_path(content)
    expect(page).to have_content 'Content updated with success'
    expect(page).to have_content 'Another Title'
    expect(page).not_to have_content 'Test Title'
    expect(page).to have_content 'Este é o texto do meu Action Text'
    expect(page).not_to have_content 'Test Body'
    expect(page).to have_content 'Public'
    expect(page).not_to have_content 'Private'
    expect(page).not_to have_content 'Tag 1'
    expect(page).to have_css("img[src*='test_avatar.png']")
  end

  it 'and clicks on cancel' do
    user = create(:user)
    tag = create(:tag, name: 'Tag 1')
    content = create(:content, title: 'Test Title', body: 'Test Body', visibility: :only_me, tags: [ tag ], user: user)

    login_as user
    visit content_path(content)
    click_on 'Edit Content'
    fill_in 'Title', with: 'Another Title'
    find_css_path = "trix-editor[input]"
    find(find_css_path).click.set("Este é o texto do meu Action Text.")
    select 'Public', from: 'Visibility'
    click_on 'Show Tags'
    uncheck 'Tag 1'
    attach_file(Rails.root.join("spec/support/files/test_avatar.png"))
    click_on 'Cancel'

    expect(current_path).to eq content_path(content)
    expect(page).not_to have_content 'Content updated with success'
    expect(page).not_to have_content 'Another Title'
    expect(page).to have_content 'Tag 1'
    expect(page).to have_content 'Private'
    expect(page).not_to have_content 'Public'
  end
end
