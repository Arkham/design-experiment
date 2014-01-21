require 'spec_helper'

describe MemberRepository do
  context "::create" do
    let(:member) { create(:member) }

    it "crawls data from member website" do
      InfoCrawler.stub(:fetch).with(member.website).and_return({
        h1: "Title, Important",
        h2: "Subtitle"
      })

      described_class.create(member)

      expect(member.h1).to eq("Title, Important")
      expect(member.h2).to eq("Subtitle")
    end

    it "shortens member website" do
    end
  end
end
