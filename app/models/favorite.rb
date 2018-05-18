class Favorite < ApplicationRecord
  
  belongs_to :blogs
  belongs_to :users
  
end
