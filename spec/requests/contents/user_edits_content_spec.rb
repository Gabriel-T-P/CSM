require 'rails_helper'

RSpec.describe "Contents", type: :request do
  describe 'User edits content' do
    it 'and its not authenticated' do
      content = create(:content)

      patch user_content_path(user_id: 1, id: content.id), params: {
        content: {
          title: 'Test Title',
          body: 'Test Body'
        }
      }

      expect(response).to have_http_status 302
      expect(response).to redirect_to new_user_session_path
      expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
    end

    it 'successfully' do
      user = create(:user)
      tag1 = create(:tag, name: 'Tag 1')
      tag2 = create(:tag, name: 'Tag 2')
      content = create(:content, title: 'Test Title', body: 'Test Body', visibility: :only_me, tags: [ tag1, tag2 ], user: user)

      login_as user
      patch user_content_path(user, content), params: {
        content: {
          title: 'Another Title',
          body: 'Another Body',
          visibility: :unlisted,
          tag_ids: []
        }
      }

      content.reload
      expect(response).to redirect_to content_path(content)
      expect(flash[:notice]).to eq 'Content updated with success'
      expect(content.title).to eq 'Another Title'
      expect(content.body.to_plain_text).to eq 'Another Body'
      expect(content.visibility).to eq 'unlisted'
      expect(content.tags.empty?).to be_truthy
    end

    it 'with wrong parameters' do
      user = create(:user)
      content = create(:content, user: user)

      login_as user
      patch user_content_path(user, content), params: {
        content: {
          title: ' ',
          body: ' '
        }
      }

      expect(response).to have_http_status 422
      expect(flash[:alert]).to eq 'Failed to update your content'
    end

    it 'for another user' do
      user = create(:user)
      other_user = create(:user)
      content = create(:content)

      login_as other_user
      patch user_content_path(user, content), params: {
        content: {
          title: 'Test Title',
          body: 'Test Body'
        }
      }

      expect(response).to have_http_status 302
      expect(response).to redirect_to user_dashboard_path(other_user)
      expect(flash[:alert]).to eq 'You can not access this page'
    end
  end
end
