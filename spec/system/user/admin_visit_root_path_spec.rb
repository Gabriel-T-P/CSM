require 'rails_helper'

describe 'Admin visits root path', type: :system do
  it 'and view navbar Admin validation' do
    admin = create(:user, role: :admin)

    login_as admin
    visit root_path

    within 'nav' do
      expect(page).to have_content 'ADMIN'
    end
  end
end
