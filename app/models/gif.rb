class Gif < ActiveRecord::Base
  # Remember to create a migration!
  validates :url, uniqueness: true
end
