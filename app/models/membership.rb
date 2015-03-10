class Membership < ActiveRecord::Base

  validates :user_id, :uniqueness => true

end
