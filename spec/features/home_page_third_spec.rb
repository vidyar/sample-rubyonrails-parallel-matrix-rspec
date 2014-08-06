require 'rails_helper'

feature 'Home page third feature' do
  before :each do
    visit root_path
  end

  scenario 'Clicking "increment" button', :js => true do
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    expect(page).to have_text 'The score is 1239'
  end

  scenario 'Repeatedly clicking "increment" button', :js => true do
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    expect(page).to have_text 'The score is 1240'
  end
end
