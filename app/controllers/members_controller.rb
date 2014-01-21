class MembersController < ApplicationController
  respond_to :html

  before_action :find_member, only: [:show, :update, :destroy]

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
    @member.friendships.build
    respond_with @member
  end

  def update
    @member.update_attributes(member_params)
    respond_with @member do |format|
      unless @member.valid?
        format.html { render 'show' }
      end
    end
  end

  def destroy
    @member.destroy
    respond_with @member
  end

  private

  def find_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :website, friendships_attributes: [:member_id, :friend_id] )
  end
end

