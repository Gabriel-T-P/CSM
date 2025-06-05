require 'rails_helper'

RSpec.describe "Admin::Tags", type: :request do
  describe 'Admin deletes tag' do
    it 'and its not authenticated' do
      tag = create(:tag)

      delete admin_tag_path(tag)

      expect(response).to have_http_status 302
      expect(response).to redirect_to new_user_session_path
      expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
    end

    it 'and its a regular user' do
      user = create(:user)
      tag = create(:tag)

      login_as user
      delete admin_tag_path(tag)

      expect(response).to have_http_status 302
      expect(response).to redirect_to root_path(locale: :en)
      expect(flash[:alert]).to eq 'You can not access this page'
    end

    it 'successfully' do
      admin = create(:user, role: :admin)
      tag = create(:tag, name: 'Test')

      login_as admin
      delete admin_tag_path(tag), params: { tag: { name: 'Not a test' } }

      expect(response).to redirect_to admin_tags_path
      expect(flash[:notice]).to eq 'Tag was successfully destroyed.'
      expect(Tag.count).to eq 0
    end

    it 'and tag id does not exist' do
      admin = create(:user, role: :admin)

      login_as admin
      delete admin_tag_path(id: 88898)

      expect(response).to have_http_status 404
    end
  end
end
