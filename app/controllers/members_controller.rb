class MembersController < ApplicationController
  respond_to :html

  before_action :find_member, only: [:show, :destroy]

  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.create(member_params)
    respond_with @member
  end

  def show
    respond_with @member
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
    params.require(:member).permit(:name, :website)
  end
end

