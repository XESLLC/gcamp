class UpdateTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :Description, :description
  end
end
