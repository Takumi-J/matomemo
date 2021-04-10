class Genre < ApplicationRecord
  
  has_many :genre_mngs, dependent: :destroy
  
end
