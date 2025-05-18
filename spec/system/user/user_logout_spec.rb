require 'rails_helper'

describe 'User logout from account', type: :system do
  it 'by navbar button' do
    user = create(:user)

    login_as user
    visit root_path

    expect(page).to have_button 'LOG OUT'
    expect(page).not_to have_link 'LOG IN'
  end

  it 'successfully' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'LOG OUT'

    expect(current_path).to eq root_path
    expect(page).to have_link 'LOG IN'
    expect(page).not_to have_button 'LOG OUT'
  end
end
