require 'rails_helper'

feature 'Home page second feature' do
  before :each do
    visit root_path
  end

  scenario 'Clicking "increment" button', :js => true do
    click_button 'Increment'
    click_button 'Increment'
    expect(page).to have_text 'The score is 1236'
  end

  scenario 'Repeatedly clicking "increment" button', :js => true do
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    click_button 'Increment'
    expect(page).to have_text 'The score is 1238'
  end
end
