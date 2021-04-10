class Review < ApplicationRecord
  
  belongs_to :member
  
  has_many :review_mngs, dependent: :destroy
  
end
