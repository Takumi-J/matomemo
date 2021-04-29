class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :work_mngs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :forum_mngs, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :review_mngs, dependent: :destroy
  
  # フォロー機能
  has_many :active_follows, class_name: "Follow", foreign_key: :following_id, dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :member
  
  def follow(other_member)
    unless self == other_member
      self.relationships.find_or_create_by(follow_id: other_member.id)
    end
  end

  def unfollow(other_member)
    relationship = self.relationships.find_by(follow_id: other_member.id)
    relationship.destroy if relationship
  end

  def following?(other_member)
    self.followings.include?(other_member)
  end

end
