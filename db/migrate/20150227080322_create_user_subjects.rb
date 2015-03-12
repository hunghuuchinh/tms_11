class CreateUserSubjects < ActiveRecord::Migration
  def change
    create_table :user_subjects do |t|
      t.integer :user_id
      t.integer :subject_id
      t.integer :status

      t.timestamps
    end
    add_index :user_subjects, :subject_id
    add_index :user_subjects, :user_id
    add_index :user_subjects, :course_id
    add_index :user_subjects, [:subject_id, :user_id, :course_id], unique: true
  end
end
