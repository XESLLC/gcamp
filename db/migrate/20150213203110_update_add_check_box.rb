class UpdateAddCheckBox < ActiveRecord::Migration
  def change
    add_column :tasks, :checkbox, :boolean
  end
end
