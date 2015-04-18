class Favorite < ActiveRecord::Base
  has_many  :users
  has_many  :dogs

  validates :dog_id, :uniqueness => {:scope => :user_id}


end
