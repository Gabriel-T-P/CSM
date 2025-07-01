require 'rails_helper'

RSpec.describe "Contents", type: :request do
  describe 'User creates content' do
    it 'and its not authenticated' do
      post  user_contents_path(user_id: 1), params: {
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

      login_as user
      post user_contents_path(user), params: {
        content: {
          title: 'Test Title',
          body: 'Test Body'
        }
      }

      expect(response).to redirect_to user_dashboard_path(user)
      expect(flash[:notice]).to eq 'Content upload with success'
    end

    it 'with wrong parameters' do
      user = create(:user)

      login_as user
      post user_contents_path(user), params: {
        content: {
          title: ' ',
          body: ' '
        }
      }

      expect(response).to have_http_status 422
      expect(flash[:alert]).to eq 'Failed to upload your content'
    end

    it 'for another user' do
      user = create(:user)
      other_user = create(:user)

      login_as other_user
      post user_contents_path(user), params: {
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
