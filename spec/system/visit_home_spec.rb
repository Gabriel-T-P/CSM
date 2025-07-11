require 'rails_helper'

describe 'Visit home test', type: :system do
  it 'successfuly' do
    visit root_path

    expect(page).to have_content 'Welcome to CSM'
  end
end

describe 'Guest changes app language', type: :system do
  it 'by navbar' do
    visit root_path

    within 'nav' do
      expect(page).to have_css('.language-button')
    end
  end

  it 'successfully' do
    visit root_path
    within 'nav' do
      find('.language-button').click
      click_on 'Português'
    end

    within 'nav' do
      expect(page).to have_link 'ENTRAR'
      expect(page).not_to have_link 'LOG IN'
    end
  end
end
