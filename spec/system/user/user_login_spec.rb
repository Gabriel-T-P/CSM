require 'rails_helper'

describe 'User login account', type: :system do
  it 'by navbar' do
    visit root_path
    within 'nav' do
      click_on 'LOG IN'
    end

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Log in'
  end
end
