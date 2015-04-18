class Dog < ActiveRecord::Base
  has_many :ratings
  has_many :users, :through => :ratings

  has_many :favorites
  has_many :users, :through => :favorites
end
