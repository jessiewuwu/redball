require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :ratings
  has_many :dogs, :through => :ratings
  has_many :favorites
  has_many :dogs, :through => :favorites

  # validates :name, presence: true
  # validates :email, presence: true, :format => { :with => VALID_EMAIL_REGEX, :message => "Enter a valid email address!"}
  # validates :username, presence: true
  # validates :password, :presence => true, length: {minimum: 6}, confirmation: true
  # validates :password_hash, length: {minimum: 6}

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
