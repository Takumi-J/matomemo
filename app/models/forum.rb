class Forum < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :forum_mngs, dependent: :destroy

  belongs_to :work
  belongs_to :member

end
