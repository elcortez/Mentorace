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


###############################################################################

lesson_1 = Lesson.create(
  chapter: chapter_1,
  position_in_chapter: 1,
  title_en: 'Definition and characteristics of a set',
  content_en: "A set is a collection, a grouping of elements. \n\n" \
    "There are two ways to define a set \n\n" \
    "* by extension : R = { x ; y ; z } \n\n" \
    "* by comprehension : { x ∈ R | (condition 1) AND (condition 2) = 0 } \n\n" \
    "* the above sentence can be read as : `x belongs to R such as (condition 1) AND (condition 2)` \n\n" \
    "(note that the ∈ symbol reads as `belongs to` and the pipe symbol | reads as `such as`) \n\n" \
    "* An empty set is written with the symbol `∅` or with impossible conditions \n\n\n" \
    "The cardinal of a set is the number of elements that it contains, \n\n" \
    "and is usually written card(E) or #(E) \n\n" \
    "Note that the cardinal of an empty set is obviously 0."
)

example_1 = Example.create(
  lesson: lesson_1,
  content_en: "let E be the set that includes all even numbers below 10 and above 0. \n" \
    "We can write E in two different manners \n\n" \
    "* extension : E = { 2 ; 4 ; 6 ; 8 } \n\n" \
    "* comprehension: { x ∈ E | (x is even) AND (x <= 10) AND (x > 0) }",
  position_in_lesson: 2
)

example_2 = Example.create(
  lesson: lesson_1,
  content_en: "let F be the set that includes all uneven numbers below 10. \n" \
    "We can write U in two different manners \n\n" \
    "* extension : U = { 1 ; 3 ; 5 ; 7 ; 9 } \n\n" \
    "* comprehension : { x ∈ U | (x is not even) AND (x <= 10) }",
  position_in_lesson: 3
)

example_3 = Example.create(
  lesson: lesson_1,
  content_en: "let G be an empty set \n" \
    "We can write G in two different manners \n\n" \
    "* extension : U = ∅ \n\n" \
    "* comprehension : { x ∈ U | (x ** x) = -1 }",
  position_in_lesson: 4
)

example_4 = Example.create(
  lesson: lesson_1,
  content_en: "let G be a set defined as follows : G = { 1 ; 2 ; 3} \n" \
    "G's cardinal is 3 because it has 3 elements \n\n" \
    "* card(G) = 3 \n\n" \
    "* #(G) = 3",
  position_in_lesson: 5
)

exercise_1 = Exercise.create(
  lesson: lesson_1,
  question_en: "Let R be a set which can be defined as follows: \n" \
    "{ x ∈ R | (x >= 5) AND (x < 10) AND (x is an integer) } \n" \
    "define R by extension",
  answer: "{ 5 ; 6 ; 7 ; 8 ; 9 }",
  position_in_lesson: 1
)

exercise_2 = Exercise.create(
  lesson: lesson_1,
  question_en: "Let S be a set which can be defined by extension as follows: \n" \
    "S = { 1 ; 2 ; 3 ; 4 ; 5 ; 6 } \n" \
    "can S be also defined by comprehension as follows? \n" \
    "{ x ∈ S | (x <= 6) AND ((x + 1) > 6) }",
  answer: 'false',
  position_in_lesson: 2
)

exercise_3 = Exercise.create(
  lesson: lesson_1,
  question_en: "Let T be a set defined as follows: " \
    "\n { x ∈ T | (x > 10) AND (x < 1) } " \
    "\n is T an empty set?",
  answer: 'true',
  position_in_lesson: 3
)

exercise_4 = Exercise.create(
  lesson: lesson_1,
  question_en: "Let U be a set defined as follows: " \
    "\n { x ∈ U | (x > 10) AND (x < 15) AND (x is an integer) } " \
    "\n how many elements does U have?",
  answer: '4',
  position_in_lesson: 4
)

exercise_5 = Exercise.create(
  lesson: lesson_1,
  question_en: "Let V be a set defined as follows: " \
    "\n { x ∈ V | (x ** x) = -1} " \
    "\n what is the cardinal of V?",
  answer: '0',
  position_in_lesson: 5
)

###############################################################################

lesson_2 = Lesson.create(
  chapter: chapter_1,
  position_in_chapter: 2,
  title_en: 'Belonging and inclusion within sets',
  content_en: "Sets can belong to one another, or include other sets. \n\n" \
    "* When a set belongs to another, we use the symbol ∈ : P ∈ R (P belongs to R) \n\n" \
    "* When a set includes another we use the symbol ⊂ : R ⊂ P (R includes P) \n\n" \
    "* You can say that a set is a subpart of another if it is included in it"
)

example_5 = Example.create(
  lesson: lesson_2,
  position_in_lesson: 1,
  content_en: "In the US, 91% of adults own a cellphone and 56% of these are smartphone \n\n" \
    "* Let A be the set including all adults in America. \n\n" \
    "* Let C be the set including all adults owning a cellphone. \n\n" \
    "* Let S be the set including all adults owning a smartphone \n\n" \
    "Here we can see that A ⊂ C ⊂ S : A includes C, which includes S \n\n" \
    "In other words : S ∈ C ∈ A : S belongs to C which belongs to A",
  img_url: 'maths_for_cs/chapter_1/lesson_2/example_1.png'
)

example_6 = Example.create(
  lesson: lesson_2,
  position_in_lesson: 2,
  content_en: "* Let N be the set including natural numbers { 1 ; 2 ; 3 ; ... } \n\n" \
    "* Let Z be the set including all integers : { ... -2 ; - 1 ; 0 ; 1 ; 2 ...} \n\n" \
    "* Let R be the set including all real numbers : { .. -1.5 ; 0.2 ; 4 ; 12 ... } \n\n" \
    "Therefore, R ⊂ Z ⊂ N and N ∈ Z ∈ R. \n\n" \
    "Also, 1 ∈ Z and 1 ∈ R and 1 ∈ N; or, N ⊂ 1 and Z ⊂ 1 and R ⊂ 1..."
  img_url: 'maths_for_cs/chapter_1/lesson_2/example_2.png'
)

example_7 = Example.create(
  lesson: lesson_2,
  position_in_lesson: 3,
  content_en: "* Thousands of animal species populate the Earth. \n\n" \
    "* Amongst them are mammals, like dolphins, monkeys, etc. Humans are mammals too ! \n\n" \
    "*  Therefore, Animals ⊂ Mammals ⊂ Humans \n\n" \
    "*  Or in other words, Humans ∈ Mammals ∈ Animals \n\n" \
    "*  Fishes are animals too, but they are not mammals  ; Therefore, Animals ⊂ Fish, " \
    "Animals ⊂ Mammals, Dolphins ∈ Mammals BUT Dolphins ∉ Fish \n\n "
  img_url: 'maths_for_cs/chapter_1/lesson_2/example_3.png'
)



###############################################################################

user = User.create(
  email: 'pierre.hersant@gmail.com',
  password: 'azertyuiopmlkjhgffdsq'
)
