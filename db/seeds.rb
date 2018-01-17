# rails db:seed / rails db:setup

course = Course.create(
  title: "One really fine course",
  description: "Don't you love it?"
)

chapter = Chapter.create(
  course: course,
  title: "First chapter of our awesome course"  
)
