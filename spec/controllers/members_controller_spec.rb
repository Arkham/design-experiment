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
      MemberRepository.should_receive(:create).with(anything)
      expect{ post 'create', member: member_data }.to change{Member.count}.by(1)
    end
  end

  describe "GET 'search_connections'" do
    let(:member) { create(:member) }
    let(:service) { double }

    it "searches for member connections" do
      SearchMemberConnections.should_receive(:new).with(member).and_return(service)
      service.should_receive(:search_topic).with("Ruby Love")
      get 'search_connections', id: member.id, search: { topic: "Ruby Love" }
    end
  end

end
