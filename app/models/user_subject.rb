class UserSubject < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  validates :user, presence: true
  validates :subject, presence: true

  private
  def course
    Course.find_by id: course_id
  end
end
