class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.create(friendship_params)
    @member = Member.find(friendship_params[:member_id])

    respond_with @friendship do |format|
      format.html { redirect_to member_path(@member) }
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy

    respond_with @friendship do |format|
      format.html { redirect_to member_path(@friendship.member) }
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:member_id, :friend_id)
  end
end
