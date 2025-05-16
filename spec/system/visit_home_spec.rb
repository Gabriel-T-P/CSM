require 'rails_helper'

describe 'Visit home test', type: :system do
  it 'successfuly' do
    visit root_path

    expect(page).to have_content 'Testing 123'
  end
end

describe 'Visit home teste js', type: :system, js: true do
  it 'successfully' do
    visit root_path

    expect(page).to have_content 'Hello World!'
  end
end
