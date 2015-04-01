class Task < ActiveRecord::Base

  belongs_to :project
  has_many :comments, dependent: :destroy
  has_many :memberships, through: :project
  
  validates :description, presence: true

end
