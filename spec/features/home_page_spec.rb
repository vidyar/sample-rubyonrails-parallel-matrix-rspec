require 'rails_helper'

feature 'Home page' do
  before :each do
    visit root_path
  end

  scenario 'Initially' do
    expect(find('h2')).to have_text 'Hello World'
    expect(page).to have_button 'Increment'
    expect(page).to have_text 'The score is 1234'
  end

  scenario 'Clicking "increment" button', :js => true do
    click_button 'Increment'
    expect(page).to have_text 'The score is 1235'
  end

  scenario 'Repeatedly clicking "increment" button', :js => true do
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    expect(page).to have_text 'The score is 1237'
  end
end
