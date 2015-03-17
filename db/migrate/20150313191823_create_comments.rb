class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text   :comments
      t.string :task_id
      t.string :user_id
      
      t.timestamps
    end
  end
end
