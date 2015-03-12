class Course < ActiveRecord::Base
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments

  validates :name,  presence: true, length: {maximum: 64}
  validates :description, presence: true, length: {maximum: 512}

  accepts_nested_attributes_for :course_subjects, allow_destroy: true
  accepts_nested_attributes_for :users, allow_destroy: true

  def course_subject_id subject
    CourseSubject.where(course: self, subject: subject).first.try :id
  end

  after_save :rebuild_assignment_data, :rebuild_user_subjects
  after_save :rebuild_user_tasks

  def rebuild_assignment_data
    us = UserSubject.where course_id: id, user: users
    ut = UserTask.where course_id: id, user: users
    if self.begin_at.nil?
      self.assignments.update_all(status: 0)
      us.update_all(status: 0)
      ut.update_all(status: 0)
    elsif self.end_at.nil?
      self.assignments.update_all(status: 1)
      us.update_all(status: 1)
      ut.update_all(status: 1)
    else
      self.assignments.update_all(status: 2)
      us.update_all(status: 2)
      ut.update_all(status: 2)
    end
  end

  def rebuild_user_subjects
    us1 = UserSubject.where course_id: id
    us2 = UserSubject.where course_id: id, user: users
    us3 = us1 - us2
    UserSubject.destroy_all id: us3.map(&:id)
  end

  def rebuild_user_tasks
    all_ut = UserTask.where course_id: id
    valid_ut = users.map{|u| UserTask.where user: u, course_id: id}.flatten
    invalid_ut = all_ut - valid_ut     
    UserTask.destroy_all id: invalid_ut.map(&:id)
  end
end
