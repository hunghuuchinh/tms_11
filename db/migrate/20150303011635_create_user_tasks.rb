class CreateUserTasks < ActiveRecord::Migration
  def change
    create_table :user_tasks do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :status

      t.timestamps
    end
    add_index :user_tasks, :task_id
    add_index :user_tasks, :user_id
    add_index :user_tasks, :course_id
    add_index :user_tasks, [:task_id, :user_id, :course_id], unique: true    
  end
end
