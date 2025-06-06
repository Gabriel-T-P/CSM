require 'rails_helper'

describe 'Admin search for tags', type: :system do
  it 'successfully' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Test Tag')
    create(:tag, name: 'Not Test 2 Tag 2')

    login_as admin
    visit root_path
    click_on 'Tags'
    fill_in placeholder: 'Search for tag name',	with: 'Test Tag'
    find('.test-search-btn').click

    expect(page).to have_content 'Test Tag'
    expect(page).not_to have_content 'Not Test 2 Tag 2'
  end

  it 'successfully but found no tag' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Test Tag')
    create(:tag, name: 'Not Test 2 Tag 2')

    login_as admin
    visit root_path
    click_on 'Tags'
    fill_in placeholder: 'Search for tag name',	with: 'Tag Number 10'
    find('.test-search-btn').click

    expect(page).to have_content 'No Tags Found'
  end

  it 'and return all tags if left blank' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Test Tag')
    create(:tag, name: 'Not Test 2 Tag 2')

    login_as admin
    visit root_path
    click_on 'Tags'
    fill_in placeholder: 'Search for tag name',	with: ' '
    find('.test-search-btn').click

    expect(page).to have_content 'Test Tag'
    expect(page).to have_content 'Not Test 2 Tag 2'
  end
end
