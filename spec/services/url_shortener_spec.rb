require 'spec_helper'

describe UrlShortener do
  let(:service) { described_class.new }
  let(:client) { service.client }
  let(:url) { "http://www.google.com" }

  context "#shorten" do

    it "shortens a given url" do
      client.stub(:shorten).with(url).and_return("shortened")
      expect(service.shorten(url)).to eq("shortened")
    end
  end
end
