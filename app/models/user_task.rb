class UserTask < ActiveRecord::Base
	belongs_to :task
  belongs_to :user

  validates :user, presence: true
  validates :task, presence: true

  private
  def course
    Course.find_by id: course_id
  end
end
