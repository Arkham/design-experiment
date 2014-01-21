require 'spec_helper'

describe InfoCrawler do
  let(:fixture) { fixture_path_for('info.html') }
  let(:page) { Nokogiri::HTML(open(fixture)) }
  let(:service) { described_class.new(page) }

  context "#fetch" do
    it "fetches given tags content" do
      expect(service.fetch(:h1, :h2, :h3)).to eq({
        h1: ["Title", "Important"],
        h2: ["Subtitle"],
        h3: ["Mini", "Small"]
      })
    end
  end
end
