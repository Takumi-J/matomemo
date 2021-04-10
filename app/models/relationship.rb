class Relationship < ApplicationRecord
  
  belongs_to :member
  belongs_to :follow, class_name: "Member"

  validates :member_id, presence: true
  validates :follow_id, presence: true
  
end
