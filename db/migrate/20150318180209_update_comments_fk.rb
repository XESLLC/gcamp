class UpdateCommentsFk < ActiveRecord::Migration
  def change
    add_foreign_key :comments, :users
  end
end
