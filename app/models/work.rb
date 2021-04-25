class Work < ApplicationRecord
  attr_accessor :image_cache
  mount_uploader :image, ImageUploader

  has_many :genre_mngs, dependent: :destroy
  has_many :actor_mngs, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :work_mngs, dependent: :destroy
  has_many :forums, dependent: :destroy

  enum medium: {
    "アニメ": '0',
    "映画": '1',
    "ドラマ": '2',
    "漫画": '3',
    "小説": '4'
  }

end
