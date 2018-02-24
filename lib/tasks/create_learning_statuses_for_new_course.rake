task create_learning_statuses_for_new_course: :environment do
  ActiveRecord::Base.transaction do
    Course.find_each do |course|
      User.find_each do |user|
        course.create_learning_status_for_user(user.id)
      end
    end
  end
end
