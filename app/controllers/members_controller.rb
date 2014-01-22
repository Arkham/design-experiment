class MembersController < ApplicationController
  respond_to :html

  before_action :find_member, only: [:show, :update, :destroy, :search_connections]

  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    MemberRepository.create(@member) if @member.save
    respond_with @member
  end

  def show
    @friendship = @member.friendships.build
    respond_with @member
  end

  def update
    @member.update_attributes(member_params)
    respond_with @member
  end

  def destroy
    @member.destroy
    respond_with @member
  end

  def search_connections
    SearchMemberConnections.new(@member).search_topic(search_params[:topic])
  end

  private

  def find_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :website)
  end

  def search_params
    params.require(:search).permit(:topic)
  end
end

