class FriendshipsController < ApplicationController
  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to member_path(@friendship.member)
  end
end
