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

describe 'Language dropdown button', type: :system, js: true do
  it 'abre o dropdown ao clicar no botão e fecha ao clicar fora' do
    visit root_path
    within 'nav' do
      find('.language-button').click
    end

    expect(page).to have_link('Português', visible: :visible)
    expect(page).to have_link('English', visible: :visible)
  end

  it 'closes dropdown clicking outside' do
    visit root_path
    within 'nav' do
      find('.language-button').click
    end
    page.find('body').click

    expect(page).to have_link('Português', visible: :hidden)
    expect(page).to have_link('English', visible: :hidden)
  end
end
