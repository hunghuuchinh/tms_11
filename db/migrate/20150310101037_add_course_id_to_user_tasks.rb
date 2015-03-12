class AddCourseIdToUserTasks < ActiveRecord::Migration
  def change
    add_column :user_tasks, :course_id, :integer
  end
end
