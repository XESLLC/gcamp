class UpdateComments < ActiveRecord::Migration
  def change
    remove_column :comments, :user_id, :string
    remove_column :comments, :task_id, :string
    remove_column :comments, :comments, :text

    add_column :comments, :user_id, :integer
    add_column :comments, :task_id, :integer
    add_column :comments, :comment, :text



  end
end
