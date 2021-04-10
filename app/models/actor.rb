class Actor < ApplicationRecord
  
  has_many :actor_mngs, dependent: :destroy
  
end
