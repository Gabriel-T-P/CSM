require 'rails_helper'

describe 'User view list of own contents', type: :system do
  it 'by navbar' do
    user = create(:user)
    content1 = create(:content, title: 'Content 1', user: user, visibility: :only_me)
    content2 = create(:content, title: 'Content 2', user: user, visibility: :unlisted)
    create(:content, title: 'Not my content')

    login_as user
    visit root_path
    within 'nav' do
      click_on 'Contents'
    end

    expect(current_path).to eq user_contents_path(user)
    expect(page).to have_content 'My Contents'
    expect(page).to have_link 'Content 1'
    expect(page).to have_content 'Private'
    expect(page).to have_content I18n.l(content1.created_at.to_date, format: :long)
    expect(page).to have_link 'Content 2'
    expect(page).to have_content 'Unlisted'
    expect(page).to have_content I18n.l(content2.created_at.to_date, format: :long)
    expect(page).not_to have_content 'Not my content'
  end

  it 'by dashboard' do
    user = create(:user)
    create(:content, title: 'Content 1', user: user)
    create(:content, title: 'Content 2', user: user)
    create(:content, title: 'Not my content')

    login_as user
    visit user_dashboard_path(user)
    click_on 'See All'

    expect(current_path).to eq user_contents_path(user)
    expect(page).to have_content 'My Contents'
    expect(page).to have_link 'Content 1'
    expect(page).to have_link 'Content 2'
    expect(page).not_to have_content 'Not my content'
  end
end
