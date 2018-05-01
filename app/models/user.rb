class User < ApplicationRecord
  
  has_secure_password
  
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  
  before_save {email.downcase!}
  
end
