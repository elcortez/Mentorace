# rails db:seed / rails db:setup

course = Course.create(
  title: 'Mathematics For Computer Science I',
  description: 'Learn how to use mathematics as a software engineer'
)

chapter = Chapter.create(
  course: course,
  title: 'First chapter',
  description: 'This is the first chapter',
  position_in_course: 1
)

############# UNIT 1 #############

unit = Unit.create(
  chapter: chapter,
  title: 'First Unit of First Chapter',
  position_in_chapter: 1
)

lesson = Lesson.create(
  unit: unit,
  content: 'this is your lesson; enjoy it !',
  position_in_unit: 1
)

unit_image = UnitImage.create(
  unit: unit,
  img_url: 'https://picsum.photos/200/300',
  position_in_unit: 2
)

example = Example.create(
  unit: unit,
  content: 'This example should explain everything to you',
  position_in_unit: 3
)

example_2 = Example.create(
  unit: unit,
  content: 'This example should explain everything to you',
  position_in_unit: 4
)


exercise = Exercise.create(
  unit: unit,
  question: 'Question for the first exercise',
  answer: 'right answer',
  position_in_unit: 1
)

exercise_2 = Exercise.create(
  unit: unit,
  question: 'Question for the first exercise',
  answer: 'right answer',
  position_in_unit: 2
)

exercise_3 = Exercise.create(
  unit: unit,
  question: 'Question for the first exercise',
  answer: 'right answer',
  position_in_unit: 3
)


############# UNIT 2 #############

unit_2 = Unit.create(
  chapter: chapter,
  title: 'Second Unit of First Chapter',
  position_in_chapter: 2
)

lesson = Lesson.create(
  unit: unit_2,
  content: 'this is your lesson; enjoy it !',
  position_in_unit: 1
)

unit_image = UnitImage.create(
  unit: unit_2,
  img_url: 'https://picsum.photos/200/300',
  position_in_unit: 2
)

example = Example.create(
  unit: unit_2,
  content: 'This example should explain everything to you',
  position_in_unit: 3
)

example_2 = Example.create(
  unit: unit_2,
  content: 'This example should explain everything to you',
  position_in_unit: 4
)


exercise = Exercise.create(
  unit: unit_2,
  question: 'Question for the first exercise',
  answer: 'right answer',
  position_in_unit: 1
)

exercise_2 = Exercise.create(
  unit: unit_2,
  question: 'Question for the first exercise',
  answer: 'right answer',
  position_in_unit: 2
)

exercise_3 = Exercise.create(
  unit: unit_2,
  question: 'Question for the first exercise',
  answer: 'right answer',
  position_in_unit: 3
)





############# UNIT 3 #############

unit_3 = Unit.create(
  chapter: chapter,
  title: 'Third Unit of First Chapter',
  position_in_chapter: 3
)

lesson = Lesson.create(
  unit: unit_3,
  content: 'this is your lesson; enjoy it !',
  position_in_unit: 1
)

unit_image = UnitImage.create(
  unit: unit_3,
  img_url: 'https://picsum.photos/200/300',
  position_in_unit: 2
)

example = Example.create(
  unit: unit_3,
  content: 'This example should explain everything to you',
  position_in_unit: 3
)

example_2 = Example.create(
  unit: unit_3,
  content: 'This example should explain everything to you',
  position_in_unit: 4
)


exercise = Exercise.create(
  unit: unit_3,
  question: 'Question for the first exercise',
  answer: 'right answer',
  position_in_unit: 1
)

exercise_2 = Exercise.create(
  unit: unit_3,
  question: 'Question for the first exercise',
  answer: 'right answer',
  position_in_unit: 2
)

exercise_3 = Exercise.create(
  unit: unit_3,
  question: 'Question for the first exercise',
  answer: 'right answer',
  position_in_unit: 3
)
