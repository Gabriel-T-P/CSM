require 'rails_helper'

RSpec.describe "Admin::Announcements", type: :request do
  describe 'Admin creates announcement' do
    it 'and its not authenticated' do
      post admin_announcements_path, params: {
        announcement: {
          title: 'Test Title',
          body: 'Test Body'
        }
      }

      expect(response).to have_http_status 302
      expect(response).to redirect_to new_user_session_path
      expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
    end

    it 'and its a regular user' do
      user = create(:user)

      login_as user
      post admin_announcements_path, params: {
        announcement: {
          title: 'Test Title',
          body: 'Test Body'
        }
      }

      expect(response).to have_http_status 302
      expect(response).to redirect_to root_path(locale: :en)
      expect(flash[:alert]).to eq 'You can not access this page'
    end

    it 'successfully' do
      admin = create(:user, role: :admin)

      login_as admin
      post admin_announcements_path, params: {
        announcement: {
          title: 'Test Title',
          body: 'Test Body'
        }
      }

      expect(response).to redirect_to admin_announcements_path
      expect(flash[:notice]).to eq 'Announcement created with success'
    end

    it 'with wrong parameters' do
      admin = create(:user, role: :admin)

      login_as admin
      post admin_announcements_path, params: {
        announcement: {
          title: 'Test Title',
          body: ' ',
          start_date: Time.current
        }
      }

      expect(response).to have_http_status 422
      expect(flash[:alert]).to eq 'Failed to create announcement'
    end
  end
end
