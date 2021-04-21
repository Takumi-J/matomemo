class Work < ApplicationRecord
  
  has_many :genre_mngs, dependent: :destroy
  has_many :actor_mngs, dependent: :destroy
  
  attachment :image
  
  enum medium:{"アニメ": 0,"映画":1,"ドラマ":2,"漫画":3,"小説":4}

end
