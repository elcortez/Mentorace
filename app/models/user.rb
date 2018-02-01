class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exercise_attempts
  has_many :learning_statuses

  after_create :create_learning_statuses

  def create_learning_statuses
    Course.find_each { |course| course.create_learning_status_for_user(self.id) }
  end
end
