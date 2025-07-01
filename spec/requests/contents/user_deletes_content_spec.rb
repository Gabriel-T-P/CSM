require 'rails_helper'

RSpec.describe "Contents", type: :request do
  describe 'User deletes content' do
    it 'and its not authenticated' do
      content = create(:content)

      delete user_content_path(user_id: 1, id: content.id)

      expect(response).to have_http_status 302
      expect(response).to redirect_to new_user_session_path
      expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
    end

    it 'successfully' do
      user = create(:user)
      content = create(:content, title: 'Test Title', user: user)

      login_as user
      delete user_content_path(user, content)

      expect(response).to redirect_to user_contents_path(user)
      expect(flash[:notice]).to eq 'Content was successfully deleted'
      expect(Content.count).to eq 0
    end

    it 'for another user' do
      user = create(:user)
      other_user = create(:user)
      content = create(:content)

      login_as other_user
      delete user_content_path(other_user, content)

      expect(response).to have_http_status 302
      expect(response).to redirect_to user_dashboard_path(other_user)
      expect(flash[:alert]).to eq 'You can not access this page'
    end

    it 'of another user' do
      user = create(:user)
      other_user = create(:user)
      content = create(:content, user: other_user)

      login_as user
      delete user_content_path(user, content)

      expect(response).to have_http_status 302
      expect(response).to redirect_to user_dashboard_path(user)
      expect(flash[:alert]).to eq 'You can not access this page'
    end
  end
end
