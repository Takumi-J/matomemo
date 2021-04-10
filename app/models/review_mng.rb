class ReviewMng < ApplicationRecord
  
  belongs_to :review
  belongs_to :member
  
end
