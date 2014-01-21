require 'spec_helper'

describe MemberRepository do
  context "::create" do
    let(:member) { create(:member) }

    before do
      InfoCrawler.stub(:fetch).with(member.website).and_return({
        h1: "Title, Important",
        h2: "Subtitle"
      })

      UrlShortener.stub(:shorten).with(member.website).and_return("shortened")

      described_class.create(member)
    end

    it "crawls data from member website" do
      expect(member.h1).to eq("Title, Important")
      expect(member.h2).to eq("Subtitle")
    end

    it "shortens member website" do
      expect(member.short_website).to eq("shortened")
    end
  end
end
