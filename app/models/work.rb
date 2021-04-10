class Work < ApplicationRecord
  
  has_many :genre_mngs, dependent: :destroy
  has_many :actor_mngs, dependent: :destroy
  
end
