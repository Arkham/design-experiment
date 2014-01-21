require 'spec_helper'

feature 'Friendship' do
  let!(:member) { create(:member) }
  let!(:friend) { create(:member) }

  scenario 'User adds friendship to member' do
    visit member_path(member)

    expect{
      select friend.name, from: 'Friend'
      click_button 'Create Friendship'
    }.to change{member.friends.count}.by(1)

    expect(friend.friends).to include(member)
  end
end
