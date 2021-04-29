class WorkMng < ApplicationRecord

  belongs_to :work
  belongs_to :member

  enum category: {
    "お気に入り": 0,
    "後で見る": 1,
    "断念": 2,
    "閲覧済み": 3,
  }

end
