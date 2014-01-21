class Member < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :website, presence: true

  has_many :friendships
  has_many :friends, through: :friendships, class_name: "Member"

  scope :except, ->(member) { where("members.id != ?", member.id) }
end
