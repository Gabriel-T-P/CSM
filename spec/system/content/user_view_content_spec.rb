require 'rails_helper'

describe 'User view detailed content', type: :system do
  it 'by dashboard' do
    user = create(:user, username: 'Test_User')
    content = create(:content, title: 'My Content', user: user)

    login_as user
    visit user_dashboard_path(user)

    expect(page).to have_selector("a[href='#{content_path(content)}']")
  end

  context 'not being the owner' do
    it 'and the content is public' do
      tag1 = create(:tag, name: 'Tag 1')
      tag2 = create(:tag, name: 'Tag 2')
      content = create(:content, title: 'My Content', body: 'My content informations', visibility: :visible_to_all, tags: [tag1, tag2])

      visit content_path(content)

      expect(current_path).to eq content_path(content)
      expect(page).to have_content 'My Content'
      expect(page).to have_content 'My content informations'
      expect(page).to have_link content.user.username, :href => profile_path(content.user.username)
      expect(page).to have_content "#{I18n.l(content.created_at.to_date, format: :long)} • Public • #Tag 1, #Tag 2"
      expect(page).to have_content 'Comments'
    end

    it 'and the content is private and user not authenticated' do
      tag1 = create(:tag, name: 'Tag 1')
      tag2 = create(:tag, name: 'Tag 2')
      content = create(:content, title: 'My Content', visibility: :only_me, tags: [tag1, tag2])

      visit content_path(content)

      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Please login to access this page'
    end

    it 'and the content is private and user not authenticated' do
      user = create(:user)
      tag1 = create(:tag, name: 'Tag 1')
      tag2 = create(:tag, name: 'Tag 2')
      content = create(:content, title: 'My Content', visibility: :only_me, tags: [tag1, tag2])

      login_as user
      visit content_path(content)

      expect(current_path).to eq user_dashboard_path(user)
      expect(page).to have_content 'You can not access this page'
    end
  end
end
