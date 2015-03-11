class User < ActiveRecord::Base
require 'bcrypt'

has_many :memberships


  validates :first_name, :last_name, :email, presence: true
  validates_uniqueness_of :email

  has_secure_password


  def full_name

    "#{first_name} #{last_name}"

  end




end
