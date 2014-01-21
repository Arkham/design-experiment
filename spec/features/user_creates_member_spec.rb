require 'spec_helper'

feature 'Member' do
  scenario 'User creates a member' do
    VCR.use_cassette('google') do
      visit new_member_path

      fill_in 'Name', with: 'Ju Liu'
      fill_in 'Website', with: 'http://www.google.com'
      click_button 'Create Member'

      expect(page).to have_text("Member was successfully created")
    end
  end
end
