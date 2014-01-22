require 'spec_helper'

feature 'Searching connections' do
  let(:member) { create(:member, name: "Member") }
  let(:friend) { create(:member, name: "Friend", h1: "Ruby Love" ) }
  let(:expert) { create(:member, name: "Expert", h1: "Ruby Love" ) }

  before do
    Friendship.create(member: member, friend: friend)
    Friendship.create(member: friend, friend: expert)
  end

  scenario "User searches member connections" do
    visit member_path(member)

    fill_in 'Topic', with: 'Ruby Love'
    click_button 'Search connections'

    expect(page).to have_content("Member > Friend > Expert")
  end
end
