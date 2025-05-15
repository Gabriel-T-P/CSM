require 'rails_helper'

describe 'User creates account', type: :system do
  it 'by navbar button' do
    visit root_path
    within 'nav' do
      click_on 'Sign up'
    end

    expect(current_path).to eq new_user_session_path  
  end
end
