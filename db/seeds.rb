# rails db:seed / rails db:setup

course = Course.create(
  title_en: "Mathematics For Computer Science",
  description_en: "Learn how to use mathematics as a software engineer"
)

chapter_1 = Chapter.create(
  course: course,
  title_en: 'Sets',
  description_en: 'What are sets, how to understand and manipulate them',
  position_in_course: 1
)

lesson_1 = Lesson.create(
  chapter: chapter_1,
  position_in_chapter: 1,
  title_en: 'Definition and characteristics of a set',
  lesson_en: "<p> A set can be defined as a collection, or a grouping of " \
    'elements; </p>' \
    "<p> there are two ways to define sets : " \
    "<ol> " \
      "<li> " \
        "by extension: write down all elements of the set between braces, " \
        "each element separated by a semicolon: " \
        "for instance R = { 1 ; 2 ; 3 ; 4 } " \
      "</li> " \
      "<li> " \
        "by comprehension: write down the conditions under which an " \
        "element can be part of a set: " \
        "\n each element must be put between simple braces: -> (x − 1) " \
        "you put them one after the other -> (x − 1)(x − 2)(x − 3)(x − 4) = 0 " \
        "\n and you define a number x that belongs (belonging symbol : ∈) " \
        "to a set R `such as` these conditions are respected. " \
        "\n The mathematical symbol for `such as` is written with the " \
        "pipe : | " \
        "\n { x ∈ R | (x − 1)(x − 2)(x − 3)(x − 4) = 0 } " \
        "\n the mathematical expression above can be read as the " \
        "following : `x belongs to the set R such as x - 1, or x - 2, " \
        "or x - 3, or x - 4 is equal to 0` " \
        "\n Therefore you can easily conclude that R is a set " \
        "that includes the numbers 1, 2, 3 and 4 " \
      "</li> " \
    "</ol> </p>"
)

example_1 = Example.create(
  lesson: lesson_1,
  content_en: "let E be the set that includes all even numbers below 10. " \
    "E = { 2 ; 4 ; 6 ; 8 } " \
    "\n or you can define E by comprehension: " \
    "\n { x ∈ E | (x / 2 is an integer) AND (x <= 10) }",
  position_in_lesson: 2
)

example_2 = Example.create(
  lesson: lesson_1,
  content_en: "let U be the set that includes all uneven numbers below 10. " \
    "U = { 1 ; 3 ; 5 ; 7 ; 9 } " \
    "\n or we can define U by comprehension: " \
    "\n { x ∈ U | (x / 2 is not an integer) AND (x <= 10) }",
  position_in_lesson: 3
)

exercise_1 = Exercise.create(
  lesson: lesson_1,
  question_en: "Let R be a set which can be defined as follows: " \
    "\n { x ∈ R | (x >= 5) AND (x < 10) AND (x is an integer) } " \
    "\n define R by extension",
  answer: "{ 5 ; 6 ; 7 ; 8 ; 9 }",
  position_in_lesson: 1
)

exercise_2 = Exercise.create(
  lesson: lesson_1,
  question_en: "Let S be a set which can be defined by extension as follows: " \
    "\n S = { 1 ; 2 ; 3 ; 4 ; 5 ; 6 } " \
    "\n can S be also defined by comprehension as follows? " \
    "\n { x ∈ S | (x <= 6) AND ((x + 1) > 6) }",
  answer: 'false',
  position_in_lesson: 2
)

lesson_2 = Lesson.create(
  lesson: lesson_1,
  content_en: "An empty set is defined as a set that contains no element." \
    "\n You can write it with the symbol : ∅ " \
    "\n Or you can write it by comprehension with an impossible equation :"
    "\n { x ∈ R | x ** x = -1 }",
  position_in_lesson: 2
)
