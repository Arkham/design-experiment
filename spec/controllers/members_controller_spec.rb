require 'spec_helper'

describe MembersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    it "creates a new member" do
      member_data = { name: "Ju Liu", website: "http://www.google.com" }
      InfoCrawler.stub(:fetch).with("http://www.google.com", :h1, :h2, :h3).and_return({ h1: "Title, Important" })
      expect{ post 'create', member: member_data }.to change{Member.count}.by(1)
      expect(Member.first.h1).to eq("Title, Important")
    end
  end

end
