class AddCourseIdToUserSubjects < ActiveRecord::Migration
  def change
    add_column :user_subjects, :course_id, :integer
  end
end
