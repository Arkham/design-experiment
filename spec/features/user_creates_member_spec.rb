require 'spec_helper'

feature 'Member' do
  scenario 'User creates a member' do
    VCR.use_cassette('eyrie') do
      visit new_member_path

      fill_in 'Name', with: 'Ju Liu'
      fill_in 'Website', with: 'http://ark.asengard.net/blog'
      click_button 'Create Member'

      expect(page).to have_text("Member was successfully created")
      expect(page).to have_text("Arkham's Eyrie")
    end
  end
end
