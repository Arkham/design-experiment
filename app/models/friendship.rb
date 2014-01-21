class Friendship < ActiveRecord::Base
  belongs_to :member
  belongs_to :friend, class_name: "Member"
  validates :member_id, uniqueness: { scope: [:friend_id] }

  after_create :create_reverse_relation
  after_destroy :destroy_reverse_relation

  def create_reverse_relation
    friend.friends << member
  end

  def destroy_reverse_relation
    friend.friendships.where(friend: member).destroy_all
  end
end
