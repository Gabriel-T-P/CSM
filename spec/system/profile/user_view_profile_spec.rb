require 'rails_helper'

xdescribe 'User views own profile page' do
  it 'by navbar' do
    user = create(:user)

    login_as user
    within 'nav' do
      click_on 'Profile'
    end

    expect(current_path).to eq profile_path
  end
end
