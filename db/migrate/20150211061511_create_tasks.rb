class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :Description
    end
  end
end
