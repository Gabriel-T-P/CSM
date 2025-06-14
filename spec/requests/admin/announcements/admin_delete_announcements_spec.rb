require 'rails_helper'

RSpec.describe "Admin::Announcements", type: :request do
  describe 'Admin deletes announcement' do
    it 'and its not authenticated' do
      announcement = create(:announcement)

      delete admin_announcement_path(announcement)

      expect(response).to have_http_status 302
      expect(response).to redirect_to new_user_session_path
      expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
    end

    it 'and its a regular user' do
      user = create(:user)
      announcement = create(:announcement)

      login_as user
      delete admin_announcement_path(announcement)

      expect(response).to have_http_status 302
      expect(response).to redirect_to root_path(locale: :en)
      expect(flash[:alert]).to eq 'You can not access this page'
    end

    it 'successfully' do
      admin = create(:user, role: :admin)
      announcement = create(:announcement)

      login_as admin
      delete admin_announcement_path(announcement)

      expect(response).to redirect_to admin_announcements_path
      expect(flash[:notice]).to eq 'Announcement deleted with success'
      expect(Announcement.count).to eq 0
    end

    it 'and announcement id does not exist' do
      admin = create(:user, role: :admin)

      login_as admin
      delete admin_announcement_path(id: 88898)

      expect(response).to have_http_status 404
    end
  end
end
