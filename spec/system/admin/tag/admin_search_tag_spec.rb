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
    visit admin_tags_path
    fill_in placeholder: 'Search for tag name',	with: 'Tag Number 10'
    find('.test-search-btn').click

    expect(page).to have_content 'No Tags Found'
  end

  it 'and return all tags if left blank' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Test Tag')
    create(:tag, name: 'Not Test 2 Tag 2')

    login_as admin
    visit admin_tags_path
    fill_in placeholder: 'Search for tag name',	with: ' '
    find('.test-search-btn').click

    expect(page).to have_content 'Test Tag'
    expect(page).to have_content 'Not Test 2 Tag 2'
  end

  it 'order by name A-Z' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Alpha', created_at: 2.days.ago)
    create(:tag, name: 'Beta', created_at: 1.day.ago)

    login_as admin
    visit admin_tags_path
    select 'Name A-Z', from: 'order'
    find('.test-search-btn').click

    expect(page).to have_content('Alpha')
    expect(page).to have_content('Beta')
    expect(page.body.index('Alpha')).to be < page.body.index('Beta')
  end

  it 'order by name Z-A' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Alpha', created_at: 2.days.ago)
    create(:tag, name: 'Beta', created_at: 1.day.ago)

    login_as admin
    visit admin_tags_path
    select 'Name Z-A', from: 'order'
    find('.test-search-btn').click

    expect(page.body.index('Beta')).to be < page.body.index('Alpha')
  end

  it 'order by most recent' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Alpha', created_at: 2.days.ago)
    create(:tag, name: 'Beta', created_at: 1.day.ago)

    login_as admin
    visit admin_tags_path
    select 'Most recent', from: 'order'
    find('.test-search-btn').click

    expect(page.body.index('Beta')).to be < page.body.index('Alpha')
  end

  it 'order by oldest (default)' do
    admin = create(:user, role: :admin)
    create(:tag, name: 'Alpha', created_at: 2.days.ago)
    create(:tag, name: 'Beta', created_at: 1.day.ago)

    login_as admin
    visit admin_tags_path
    select 'Oldest', from: 'order'
    find('.test-search-btn').click

    expect(page.body.index('Alpha')).to be < page.body.index('Beta')
  end
end
