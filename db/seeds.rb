# rails db:seed / rails db:setup

course = Course.create(title: 'maths_for_cs')

chapter = Chapter.create(
  course: course,
  title: 'sets',
  description: 'sets',
  position_in_course: 1
)

unit = Unit.create(
  chapter: chapter,
  title: 'definition',
  position_in_chapter: 1
)

lesson = Lesson.create(
  unit: unit,
  content: 'first_definition'
  position_in_unit: 1
)

example = Example.create(
  unit: unit,
  content: 'example_1',
  position_in_unit: 3
)

example_2 = Example.create(
  unit: unit,
  content: 'example_2',
  position_in_unit: 3
)

exercise = Exercise.create(
  unit: unit,
  question: 'exercise_1',
  answer: 'exercise_1',
  position_in_unit: 1
)

exercise_2 = Exercise.create(
  unit: unit,
  question: 'exercise_2',
  answer: 'exercise_2',
  position_in_unit: 1
)

# image = Image.create(
#   unit: unit,
#   img_url: 'https://picsum.photos/200/300',
#   position_in_unit: 2
# )
