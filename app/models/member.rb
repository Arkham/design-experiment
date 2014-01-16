class Member < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :website, presence: true
end
