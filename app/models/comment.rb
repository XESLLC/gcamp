class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :comment, presence: :true
  validates :user_id, presence: :true
  validates :task_id, presence: :true
end
