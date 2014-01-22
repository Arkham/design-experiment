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

    context "multiple headers" do
      let(:other) { create(:member, name: "Other", h3: "Metaprogramming") }
      before do
        Friendship.create(member: expert, friend: other)
      end

      it "supports multiple header matching" do
        first = service.search_topic("Metaprogramming").first
        expect(first.path).to eq([member, friend, expert, other])
      end
    end

    context "multiple matches" do
      let(:other) { create(:member, name: "Other", h1: "Metaprogramming") }
      before do
        expert.update_attributes(h2: "Metaprogramming")
        Friendship.create(member: expert, friend: other)
      end

      it "prefers h1 matches over h2 matches" do
        first, second = service.search_topic("Metaprogramming")
        expect(first.path).to eq([member, friend, expert, other])
        expect(second.path).to eq([member, friend, expert])
      end
    end

    context "multiple paths" do
      let(:other) { create(:member, name: "Other") }
      before do
        Friendship.create(member: friend, friend: other)
        Friendship.create(member: other, friend: expert)
      end

      it "returns only the shortest path to an expert" do
        expect(service.search_topic("Ruby Love").count).to eq(1)
        expect(service.search_topic("Ruby Love").first.path).to eq([
          member, friend, expert
        ])
      end
    end

  end
end
