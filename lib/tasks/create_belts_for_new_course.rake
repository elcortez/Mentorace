task create_belts_for_new_course: :environment do
  ActiveRecord::Base.transaction do
    Course.find_each do |course|
      User.find_each do |user|
        course.create_belts_for_user(user.id)
      end
    end
  end
end
