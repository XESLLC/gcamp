class User < ActiveRecord::Base
require 'bcrypt'


  validates :first_name, :last_name, :email, presence: true
  validates_uniqueness_of :email

  has_secure_password




end
