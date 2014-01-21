require 'spec_helper'

describe Friendship do
  context "reverse friendship" do
    let!(:member) { create(:member) }
    let!(:friend) { create(:member) }

    it "creates both sides of the relation" do
      Friendship.create(member: member, friend: friend)
      expect(member.friends).to include(friend)
      expect(friend.friends).to include(member)
    end

    it "destroys both sides of the relation" do
      friendship = Friendship.create(member: member, friend: friend)
      friendship.destroy
      expect(member.friends).not_to include(friend)
      expect(friend.friends).not_to include(member)
    end
  end
end
