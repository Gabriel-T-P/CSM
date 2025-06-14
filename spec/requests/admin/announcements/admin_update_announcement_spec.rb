require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe "Admin::Announcements", type: :request do
  describe 'Admin updates announcement' do
    it 'and its not authenticated' do
      announcement = create(:announcement)

      patch admin_announcement_path(announcement), params: {
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
      announcement = create(:announcement)

      login_as user
      patch admin_announcement_path(announcement), params: {
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
      freeze_time
      announcement = create(:announcement, title: 'Test Title', body: 'Test Body', start_at: Time.current, end_at: 5.days.from_now)

      login_as admin
      patch admin_announcement_path(announcement), params: {
        announcement: {
          title: 'Another Title',
          body: 'Another Body'
        }
      }

      announcement.reload
      expect(response).to redirect_to admin_announcements_path
      expect(announcement.title).to eq 'Another Title'
      expect(announcement.body).to eq 'Another Body'
      expect(announcement.start_at).to eq Time.current
      expect(announcement.end_at).to eq 5.days.from_now
    end

    it 'with wrong parameters' do
      admin = create(:user, role: :admin)
      announcement = create(:announcement, title: 'Test Title', body: 'Test Body')

      login_as admin
      patch admin_announcement_path(announcement), params: {
        announcement: {
          title: '',
          body: 'Another Body',
          start_at: Time.current
        }
      }

      expect(response).to have_http_status :unprocessable_entity
      announcement.reload
      expect(announcement.title).to eq('Test Title')
      expect(announcement.body).to eq('Test Body')
    end

    it 'and announcement id does not exist' do
      admin = create(:user, role: :admin)

      login_as admin
      patch admin_announcement_path(999), params: {
        announcement: {
          title: ' ',
          body: 'Another Body',
          start_at: Time.current
        }
      }

      expect(response).to have_http_status 404
    end
  end
end
