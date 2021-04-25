class Review < ApplicationRecord

  belongs_to :member
  belongs_to :work

  has_many :review_mngs, dependent: :destroy

end
