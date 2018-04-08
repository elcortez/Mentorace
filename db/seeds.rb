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

Example.create(
  lesson: lesson_1,
  content_en: "let E be the set that includes all even numbers below 10 and above 0. \n" \
    "We can write E in two different manners \n\n" \
    "* extension : E = { 2 ; 4 ; 6 ; 8 } \n\n" \
    "* comprehension: { x ∈ E | (x is even) AND (x <= 10) AND (x > 0) }",
  position_in_lesson: 2
)

Example.create(
  lesson: lesson_1,
  content_en: "let F be the set that includes all uneven numbers below 10. \n" \
    "We can write U in two different manners \n\n" \
    "* extension : U = { 1 ; 3 ; 5 ; 7 ; 9 } \n\n" \
    "* comprehension : { x ∈ U | (x is not even) AND (x <= 10) }",
  position_in_lesson: 3
)

Example.create(
  lesson: lesson_1,
  content_en: "let G be an empty set \n" \
    "We can write G in two different manners \n\n" \
    "* extension : U = ∅ \n\n" \
    "* comprehension : { x ∈ U | (x ** x) = -1 }",
  position_in_lesson: 4
)

Example.create(
  lesson: lesson_1,
  content_en: "let G be a set defined as follows : G = { 1 ; 2 ; 3} \n" \
    "G's cardinal is 3 because it has 3 elements \n\n" \
    "* card(G) = 3 \n\n" \
    "* #(G) = 3",
  position_in_lesson: 5
)

Exercise.create(
  lesson: lesson_1,
  question_en: "Let R be a set which can be defined as follows: \n" \
    "{ x ∈ R | (x >= 5) AND (x < 10) AND (x is an integer) } \n" \
    "define R by extension",
  answer: "{ 5 ; 6 ; 7 ; 8 ; 9 }",
  position_in_lesson: 1
)

Exercise.create(
  lesson: lesson_1,
  question_en: "Let S be a set which can be defined by extension as follows: \n" \
    "S = { 1 ; 2 ; 3 ; 4 ; 5 ; 6 } \n" \
    "can S be also defined by comprehension as follows? \n" \
    "{ x ∈ S | (x <= 6) AND ((x + 1) > 6) }",
  answer: 'false',
  position_in_lesson: 2
)

Exercise.create(
  lesson: lesson_1,
  question_en: "Let T be a set defined as follows: " \
    "\n { x ∈ T | (x > 10) AND (x < 1) } " \
    "\n is T an empty set?",
  answer: 'true',
  position_in_lesson: 3
)

Exercise.create(
  lesson: lesson_1,
  question_en: "Let U be a set defined as follows: " \
    "\n { x ∈ U | (x > 10) AND (x < 15) AND (x is an integer) } " \
    "\n how many elements does U have?",
  answer: '4',
  position_in_lesson: 4
)

Exercise.create(
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

Example.create(
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

Example.create(
  lesson: lesson_2,
  position_in_lesson: 2,
  content_en: "* Let N be the set including natural numbers { 1 ; 2 ; 3 ; ... } \n\n" \
    "* Let Z be the set including all integers : { ... -2 ; - 1 ; 0 ; 1 ; 2 ...} \n\n" \
    "* Let R be the set including all real numbers : { .. -1.5 ; 0.2 ; 4 ; 12 ... } \n\n" \
    "Therefore, R ⊂ Z ⊂ N and N ∈ Z ∈ R. \n\n" \
    "Also, 1 ∈ Z and 1 ∈ R and 1 ∈ N; or, N ⊂ 1 and Z ⊂ 1 and R ⊂ 1...",
  img_url: 'maths_for_cs/chapter_1/lesson_2/example_2.png'
)

Example.create(
  lesson: lesson_2,
  position_in_lesson: 3,
  content_en: "* Thousands of animal species populate the Earth. \n\n" \
    "* Amongst them are mammals, like dolphins, monkeys, etc. Humans are mammals too ! \n\n" \
    "*  Therefore, Animals ⊂ Mammals ⊂ Humans \n\n" \
    "*  Or in other words, Humans ∈ Mammals ∈ Animals \n\n" \
    "*  Fishes are animals too, but they are not mammals  ; Therefore, Animals ⊂ Fish, " \
    "Animals ⊂ Mammals, Dolphins ∈ Mammals BUT Dolphins ∉ Fish \n\n",
  img_url: 'maths_for_cs/chapter_1/lesson_2/example_3.png'
)

Exercise.create(
  lesson: lesson_2,
  position_in_lesson: 1,
  question_en: 'Let N be a set which has a cardinal of 0; Does 0 ∈ N ?',
  answer: 'false'
)

Exercise.create(
  lesson: lesson_2,
  position_in_lesson: 2,
  question_en: "* N = { x ∈ N | (x > 1) && (x < 10) } \n\n" \
    "* P = { x ∈ P | (x > 5) && (x <= 10) } \n\n" \
    "Does N ⊂ P?",
  answer: 'false'
)

Exercise.create(
  lesson: lesson_2,
  position_in_lesson: 3,
  question_en: "* N = { 1 ; 2 ; 3 } \n\n" \
    "* P = { 4 ; 5 ; 6 } \n\n" \
    "* We know that Q ⊂ N and Q ⊂ P \n\n" \
    "What is Q's cardinal?",
  answer: '6',
)

Exercise.create(
  lesson: lesson_2,
  position_in_lesson: 4,
  question_en: "* N = { 1 ; 3 ; 5 } \n\n" \
    "* P = { 1 ; 3 ; 5 ; 7 ; 9 ; 11 } \n\n" \
    "* We know that  Q ⊂ N AND P ⊂ Q ; however 9 ∉ Q  \n\n" \
    "Define Q by extension",
  answer: '{ 1 ; 3 ; 5 ; 7 ; 11 } ',
)

Exercise.create(
  lesson: lesson_2,
  position_in_lesson: 4,
  question_en: "* Let N, P and Q be 3 sets. \n\n" \
   "* N ⊂ P and P ⊂ Q \n\n" \
   "Does N ⊂ Q ?",
  answer: 'true',
)

###############################################################################

lesson_3 = Lesson.create(
  chapter: chapter_1,
  position_in_chapter: 3,
  title_en: 'Parts of a set',
  content_en: "A set is part of another if it is included in it. \n\n" \
    "You can decide to call this a part or a subset. \n\n" \
    "Here, inclusion is to be taken at the largest possible definition, meaning " \
    "a set Q always includes itself and the empty set ø. \n\n" \
    "For any given set Q, the set containing its parts is written P(Q) " \
    "If a set Q contains n elements, P(Q) will contains 2**n elements."
)

Example.create(
  lesson: lesson_3,
  position_in_lesson: 1,
  content_en: "Let N be a set defined as the following : N = { 1 ; 2 ; 3 } \n\n" \
    "* Then P(N) = { ∅ ; { 1 } ; { 2 } ; { 3 } ; {1 ; 2 } ; { 2 ; 3 } ; {1 ; 3} ; { 1 ; 2 ; 3 } } \n\n" \
    "* The cardinal of N can be written |N| \n\n" \
    "* The cardinal of P(N) can be written |P(N)| \n\n" \
    "* As you can see, |N| = 3, and |P(N)| = 2**3 = 8"
)

Example.create(
  lesson: lesson_3,
  position_in_lesson: 2,
  content_en: "Let N be a set defined as an empty set : ø \n\n" \
    "Then P(N) = { ø } \n\n" \
    "|N| = 0 (because N is empty) \n\n" \
    "|P(N)| = 2**0 = 1 \n\n"
)

Example.create(
  lesson: lesson_3,
  position_in_lesson: 3,
  content_en: "Let N be defined as = N = { 1 } \n\n" \
    "Then P(N) = { ø ; { 1 } } \n\n" \
    "|N| = 1 \n\n" \
    "|P(N)| = 2**1 = 2 \n\n"
)


Exercise.create(
  lesson: lesson_3,
  position_in_lesson: 1,
  question_en: "Let N be a set defined this way : { 1 ; 2 ; 3 ; 4 ; 5 } \n\n" \
   "How many parts does P(N) have ? \n\n",
  answer: '32'
)

Exercise.create(
  lesson: lesson_3,
  position_in_lesson: 2,
  question_en: "Let P(N) a collection of parts from a set defined as follows \n\n" \
   "P(N) = { {ø} {3} {5} {3 ; 5} } \n\n" \
   "Define the cardinal of N, |N|",
  answer: '2'
)

Exercise.create(
  lesson: lesson_3,
  position_in_lesson: 3,
  question_en: "If N ⊂ M, does P(M) ⊂ P(M)?",
  answer: 'true'
)

Exercise.create(
  lesson: lesson_3,
  position_in_lesson: 4,
  question_en: "Let N be a set defined as follows : N = { 10 ; 15 ; 20 ; 25 } \n\n" \
    "Let M be a set defined as follows : { x ∈ M | (x >= 10) AND (x < 30) AND (x / 10 ∈ N) } \n\n" \
    "Is M a part of N? \n\n" \
    "Reminder : N is the set including all natural integers.",
  answer: 'true'
)

###############################################################################

lesson_4 = Lesson.create(
  chapter: chapter_1,
  position_in_chapter: 4,
  title_en: 'Cartesian product',
  content_en: "a Cartesian product is an operation that returns a set from multiple sets. \n\n" \
  "For sets A and B, the Cartesian product A × B is the set of all ordered pairs (a, b) where a ∈ A and b ∈ B. \n\n" \
  "You can call the result of that set product set, or simply product \n\n" \
  "The product set is NOT commutative, meaning A x B ≠ B x A unless A = B \n\n" \
  "For two sets A and B, |A x B| = |A| x |B| \n\n" \
  "This also works if you create products with more than two sets : |A x B x C| = |A| x |B| x |C| \n\n" \
  "Elements belonging to the sets are called p-lists. \n\n" \
  "You can also multiply a set by itself, which means you will raise the set to the power of p. \n\n" \
  "In that case, |Eⁿ| = |E|ⁿ"
)

Example.create(
  lesson: lesson_4,
  position_in_lesson: 1,
  content_en: "E = { 1 ; 2 ; 3 } \n\n" \
    "F = { 4 ; 5 ; 6 }" \
    "E x F will be a set including all results of the following table, " \
    "and each element will be its p-list.",
  img_url: 'maths_for_cs/chapter_1/lesson_4/example_1.png'
)

Example.create(
  lesson: lesson_4,
  position_in_lesson: 2,
  content_en: "What time is it? \n\n" \
    "* Let H be the set including all possible hours H = {x ∈ H | x <= 12 AND x ∈ N} \n\n" \
    "* Let M be the set including all possible minutes M = { x ∈  M | x <= 59 AND x ∈ N} \n\n" \
    "* The current time is a part of H x M  \n\n" \
    "* Which is why H x M ≠ M x H ; If it is 11:09, it is not 09:11 !",
  img_url: 'maths_for_cs/chapter_1/lesson_4/example_2.png'
)

Example.create(
  lesson: lesson_4,
  position_in_lesson: 3,
  content_en: "What are the coordinates of your home ? \n\n" \
    "Let T be the latitude, G the longitude \n\n" \
    "T = { x ∈ T | x <= 90 AND x >= -90 AND x ∈ R } \n\n" \
    "G = { x ∈ G | x <= 180 AND x >= -180 AND x ∈ R } \n\n" \
    "(Reminder : R is the set including all real numbers) \n\n" \
    "Your coordinates are a subset of the product T x G \n\n" \
    "The city of Paris, in France, for instance has approximately the following coordinates : { 48,51 ; 2,20 } \n\n",
  img_url: 'maths_for_cs/chapter_1/lesson_4/example_3.png'
)

Example.create(
  lesson: lesson_4,
  position_in_lesson: 4,
  content_en: "A = {1,2}; B = {3,4} C = { 5 } \n\n" \
    "A × B x C = {1,2} × {3,4} x {5}= {(1,3,5), (1,4,5), (2,3,5), (2,4,5)} \n\n" \
    "B × A x C= {3,4} × {1,2} x {5} = {(3,1,5), (3,2,5), (4,1,5), (4,2,5)} \n\n" \
    "Again, the order pf the p-lists matters, even with 3 sets"
)

Example.create(
  lesson: lesson_4,
  position_in_lesson: 5,
  content_en: "What is the number of possibilities for a 4-digit credit card number? \n\n" \
    "Since each digit can go from 0 to 9, our basic set C is {0; 1; 2; 3; 4; 5; 6; 7; 8; 9} \n\n" \
    "Since we have 4 digits, we have to raise this set to the power of 4 \n\n" \
    "Therefore, |C| = 10, and |C⁴| = |C|⁴ = 10⁴ = 10000. \n\n" \
    "In other mathematical words, we call this a ‘repeated permutation’"
)

Exercise.create(
  lesson: lesson_4,
  position_in_lesson: 1,
  question_en: "Let’s roll a 6-faces die twice. \n\n" \
    "We expect a result looking like this : { first roll ; second roll } \n\n" \
    "What are the number of possible combinations? ",
  answer: '36'
)

Exercise.create(
  lesson: lesson_4,
  position_in_lesson: 2,
  question_en: "Let’s roll a 6-faces die three times. \n\n" \
    "We expect a result looking like this : { first roll ; second roll ; third roll } \n\n" \
    "What are the number of possible values?",
  answer: '216'
)

Exercise.create(
  lesson: lesson_4,
  position_in_lesson: 3,
  question_en: "If we flip a coin 5 times, one after the other, how many different set of face/toes can we have in total?",
  answer: '32'
)

Exercise.create(
  lesson: lesson_4,
  position_in_lesson: 4,
  question_en: "A = { 1 ; 2 ; 3 } \n\n" \
  "B = { 2 ; 3 ; 5 } \n\n" \
  "C = { 7 ; 8 ; 9 } \n\n" \
  "Is { 5 ; 2 ; 9 } a subpart of the set A x B x C?",
  answer: 'false'
)

Exercise.create(
  lesson: lesson_4,
  position_in_lesson: 5,
  question_en: "We grade 5 students from A to F. How many sets of grades are possible?",
  answer: '7776'
)

Exercise.create(
  lesson: lesson_4,
  position_in_lesson: 6,
  question_en: "What are the different possibilites for an 8-digit phone number?",
  answer: '100000000'
)

###############################################################################

lesson_5 = Lesson.create(
  chapter: chapter_1,
  position_in_chapter: 5,
  title_en: 'Intersection, reunion, and complementation',
  content_en: ""
)

###############################################################################
user = User.create(
  email: 'pierre.hersant@gmail.com',
  password: 'azertyuiopmlkjhgffdsq'
)
