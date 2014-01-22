require 'spec_helper'

describe SearchMemberConnections do
  let(:member) { create(:member, name: "Member") }
  let(:service) { described_class.new(member) }

  context "#search_topic" do
    let(:friend) { create(:member, name: "Friend", h1: "Ruby Love") }
    let(:expert) { create(:member, name: "Expert", h1: "Ruby Love") }

    before do
      Friendship.create(member: member, friend: friend)
      Friendship.create(member: friend, friend: expert)
    end

    it "finds non-direct connections matching topic" do
      first = service.search_topic("Ruby Love").first

      expect(first.path).to eq([member, friend, expert])
      expect(first.match).to eq("Ruby Love")
    end
  end
end
