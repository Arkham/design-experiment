class Member < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :website, presence: true

  has_many :friendships
  has_many :friends, through: :friendships, class_name: "Member"

  accepts_nested_attributes_for :friendships, reject_if: :all_blank

  scope :except, ->(member) { where("members.id != ?", member.id) }
end
