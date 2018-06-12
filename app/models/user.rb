class User < ApplicationRecord
  
  has_secure_password
  
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  
  before_save {email.downcase!}
  
  has_many :blogs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_blogs, through: :favorites, source: :blog
  
  mount_uploader :image, ImageUploader
  
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  
  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end
  
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
end