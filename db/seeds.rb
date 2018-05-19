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
    "We can write F in two different manners \n\n" \
    "* extension : F = { 1 ; 3 ; 5 ; 7 ; 9 } \n\n" \
    "* comprehension : { x ∈ U | (x is not even) AND (x <= 10) AND (x > 0) }",
  position_in_lesson: 3
)

Example.create(
  lesson: lesson_1,
  content_en: "let G be an empty set \n" \
    "We can write G in two different manners \n\n" \
    "* extension : U = ∅ \n\n" \
    "* comprehension : { x ∈ U | (xᵡ) = -1 } \n\n" \
    "* xᵡ means x to the power of x, and can also be writter x ** x \n\n" \
    "* No number raised to the power of itself can even be negative, which is why the set must be empty",
  position_in_lesson: 4
)

Example.create(
  lesson: lesson_1,
  content_en: "let G be a set defined as follows : G = { 4 ; 8 ; 13 } \n" \
    "G's cardinal is 3 because it has 3 elements \n\n" \
    "* card(G) = 3 \n\n" \
    "* #(G) = 3 \n\n" \
    "* |G| = 3 \n\n" \
    "Each one of these writings can be used the same way, and in the following " \
    "lessons, we will use mostly the following version : |G|",
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
    "{ x ∈ S | (x <= 6) AND ((x + 1) > 6) AND (x is an integer) }",
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
    "* When a set is included into another we use the symbol ⊂ : P ⊂ R (which means that P is a subpart of R, or that R includes P) \n\n" \
    "* You can say that a set is a subpart of another if it is included in it \n\n" \
    "* You can also use this symbol the other way around : R ⊃ P : R includes P" \
)

Example.create(
  lesson: lesson_2,
  position_in_lesson: 1,
  content_en: "In the US, 91% of adults own a cellphone and 56% of these are smartphone \n\n" \
    "* Let A be the set including all adults in America. \n\n" \
    "* Let C be the set including all adults owning a cellphone. \n\n" \
    "* Let S be the set including all adults owning a smartphone \n\n" \
    "Here we can see that S ⊂ C ⊂ A: A includes C, which includes S \n\n" \
    "In other words : S ∈ C ∈ A : S belongs to C which belongs to A",
  img_url: 'maths_for_cs/chapter_1/lesson_2/example_1.png'
)

Example.create(
  lesson: lesson_2,
  position_in_lesson: 2,
  content_en: "* Let N be the set including natural numbers { 1 ; 2 ; 3 ; ... } \n\n" \
    "* Let Z be the set including all integers : { ... -2 ; - 1 ; 0 ; 1 ; 2 ...} \n\n" \
    "* Let R be the set including all real numbers : { .. -1.5 ; 0.2 ; 4 ; 12 ... } \n\n" \
    "Therefore, N ⊂ Z ⊂ R and N ∈ Z ∈ R. \n\n" \
    "Also, 1 ∈ Z and 1 ∈ R and 1 ∈ N",
  img_url: 'maths_for_cs/chapter_1/lesson_2/example_2.png'
)

Example.create(
  lesson: lesson_2,
  position_in_lesson: 3,
  content_en: "* Thousands of animal species populate the Earth. \n\n" \
    "* Amongst them are mammals, like bears, monkeys, etc. Humans are mammals too ! \n\n" \
    "* Therefore, Humans ⊂ Mammals ⊂ Animals (Humans are a subpart of Mammals, etc.) \n\n" \
    "* Or in other words, Animals ⊃ Mammals ⊃ Humans \n\n" \
    "* Fishes are animals too, but they are not mammals  ; Therefore, Fish ⊂ Animals, " \
    "Mammals ⊂ Animals, Bears ⊂ Mammals BUT Bears ⊄ Fish \n\n",
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
    "Does P ⊂ N ?",
  answer: 'false'
)

Exercise.create(
  lesson: lesson_2,
  position_in_lesson: 3,
  question_en: "* N = { 1 ; 2 ; 3 } \n\n" \
    "* P = { 4 ; 5 ; 6 } \n\n" \
    "* We know that N ⊂ Q and P ⊂ Q \n\n" \
    "What is Q's cardinal?",
  answer: '6',
)

Exercise.create(
  lesson: lesson_2,
  position_in_lesson: 4,
  question_en: "* N = { 1 ; 3 ; 5 } \n\n" \
    "* P = { 1 ; 3 ; 5 ; 7 ; 9 ; 11 } \n\n" \
    "* We know that N ⊂ Q AND Q ⊂ P ; however 9 ∉ Q  \n\n" \
    "Define Q by extension",
  answer: '{ 1 ; 3 ; 5 ; 7 ; 11 } ',
)

Exercise.create(
  lesson: lesson_2,
  position_in_lesson: 4,
  question_en: "* Let N, P and Q be 3 sets. \n\n" \
   "* P ⊂ N and Q ⊂ P \n\n" \
   "Does Q ⊂ N ?",
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
    "For any given set Q, the set containing its parts is written P(Q) \n\n" \
    "If a set Q contains n elements, P(Q) will contains 2**n elements. \n\n" \
    "Remember the cardinal of a set Q is written |Q|. \n\n" \
    "Therefore, the cardinal of its parts P(Q) is written |P(Q)|. "
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
   "How many parts does P(N) have ? (Meaning, what is |P(N)| ?) \n\n",
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
  question_en: "Let M be a set defined as follows : M = { 10 ; 15 ; 20 ; 25 } \n\n" \
    "Let P be a set defined as follows : { x ∈ P | (x >= 10) AND (x < 30) AND (x / 10 ∈ M) } \n\n" \
    "Is P a part of M? \n\n",
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
  "The product set is NOT associative, meaning A x B x C ≠ A x (B x C) ≠ (A x B) x C \n\n" \
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
  title_en: 'Intersection of sets',
  content_en: "An intersection between two sets is a new set that groups all elements that belong to both sets. \n\n" \
    "Every element that is in the set A AND in the set B will be present in this set. \n\n" \
    "Its symbol is the following : ⋂ \n\n" \
    "Intersections is commutative, which mean A ⋂ B = B ⋂ A \n\n" \
    "Intersections are associative, which means : (A ⋂ B) ⋂ C = A ⋂ (B ⋂ C) \n\n" \
    "Intersections are idempotents, which means A ⋂ A = A \n\n" \
    "Whichever set A exists, A ⋂ ∅ = ∅ \n\n" \
    "If A ⋂ B = ∅, then A and B are disjoints, which means no element from A can be found in B."
)

Example.create(
  lesson: lesson_5,
  position_in_lesson: 1,
  content_en: "A = { 1 ; 2 ; 3 } \n\n" \
    "B = { 3 ; 4 ; 5 } \n\n" \
    "A ⋂ B = { 3 }",
    img_url: 'maths_for_cs/chapter_1/lesson_5/example_1.png'
)

Example.create(
  lesson: lesson_5,
  position_in_lesson: 2,
  content_en: "A = { 1 ; 2 ; 3 } \n\n" \
    "B = { 4 ; 5 } \n\n" \
    "A ⋂ B = ∅ \n\n" \
    "Here A and B are disjoints",
  img_url: 'maths_for_cs/chapter_1/lesson_5/example_2.png'
)

Example.create(
  lesson: lesson_5,
  position_in_lesson: 3,
  content_en: "A = { 1 ; 2 ; 3 } \n\n" \
    "B = { 2 ; 3 ; 4 ; 5 } \n\n" \
    "C = { 3 ; 7 ; 8 } \n\n" \
    "A ⋂ B = { 2 ; 3 } \n\n" \
    "A ⋂ C = { 3 } \n\n" \
    "(A ⋂ B) ⋂ C = A ⋂ (B ⋂ C) = { 3 }"
)

Exercise.create(
  lesson: lesson_5,
  position_in_lesson: 1,
  question_en: "A = { 2 ; 4 ; 8 ; 52 ; 78 } \n\n" \
    "B = { 78 ; 87 } \n\n" \
    "Define A ⋂ B",
  answer: '{ 78 }'
)

Exercise.create(
  lesson: lesson_5,
  position_in_lesson: 2,
  question_en: "N = { x ∈ N | x > 1 AND x is an integer AND x < 5 } \n\n" \
    "M = { 3 ; 4 } \n\n" \
    "What is the number |P(N ⋂ M)| ? \n\n",
  answer: '4'
)

Exercise.create(
  lesson: lesson_5,
  position_in_lesson: 3,
  question_en: "if R ⋂ P = A and  A ⋂ P = P, then Does P ⊂ R ?",
  answer: 'true'
)

Exercise.create(
  lesson: lesson_5,
  position_in_lesson: 4,
  question_en: "if B ∈ C and C ⋂ D = B, then Does D = B?",
  answer: 'false'
)


Exercise.create(
  lesson: lesson_5,
  position_in_lesson: 5,
  question_en: "if B ∈ (A ⋂ C) and C ∈ (A ⋂ B), then Is B = C?",
  answer: 'true'
)

###############################################################################
lesson_6 = Lesson.create(
  chapter: chapter_1,
  position_in_chapter: 6,
  title_en: 'Union of sets',
  content_en: "The unions of two sets A and B are a new set C containing all elements that belongs to any set.\n\n" \
    "Every element that is in the set A OR in the set B will be present in this set. \n\n" \
    "Its symbol is the following : ∪ \n\n" \
    "Unions are commutative, which mean A ∪ B = B ∪ A. \n\n" \
    "Unions are associative, which means (A ∪ B) ∪ C = A ∪ (B ∪ C) = A ∪ B ∪ C \n\n" \
    "Unions are idempotents, which mean A ∪ A = A \n\n" \
    "Whichever set A exists, A ∪ ø = A \n\n" \
    "If A ∪ B = ø, it means A = ø and B = ø. \n\n"
)

Example.create(
  lesson: lesson_6,
  position_in_lesson: 1,
  content_en: "A ∪ B",
  img_url: 'maths_for_cs/chapter_1/lesson_6/example_1.png'
)

Example.create(
  lesson: lesson_6,
  position_in_lesson: 2,
  content_en: "(A ∪ B) ⋂ C = (A ⋂ B) ∪ (B ⋂ C)",
  img_url: 'maths_for_cs/chapter_1/lesson_6/example_2.png'
)


Example.create(
  lesson: lesson_6,
  position_in_lesson: 3,
  content_en: "(A ⋂ B) ∪ C = (A ∪ C) ⋂ (B ∪ C)",
  img_url: 'maths_for_cs/chapter_1/lesson_6/example_3.png'
)

Example.create(
  lesson: lesson_6,
  position_in_lesson: 4,
  content_en: "(A ⋂ B) ∪ (B ∪ C)",
  img_url: 'maths_for_cs/chapter_1/lesson_6/example_4.png'
)

Exercise.create(
  lesson: lesson_6,
  position_in_lesson: 1,
  question_en: "A = { 1 ; 2 ; 3 } \n\n" \
    "B = { 4 } \n\n" \
    "Define A ∪ B",
  answer: '{ 1 ; 2 ; 3 ; 4 }',
  hint: '{ a ; b ; c }'
)

Exercise.create(
  lesson: lesson_6,
  position_in_lesson: 2,
  question_en: "A = { 1 ; 2 ; 3 } \n\n" \
  "B = { 3 ; 4 } \n\n" \
  "C = { 4 ; 5 ; 6 } \n\n" \
  "Define (A ∪ B) ⋂ C",
  answer: '{ 4 }',
  hint: '{ a ; b ; c }'
)

Exercise.create(
  lesson: lesson_6,
  position_in_lesson: 3,
  question_en: "Is (A ∪ B) ⋂ (A ∪ C) ⋂ (B ∪ C) = A ∪ B ∪ C?",
  answer: 'true'
)

Exercise.create(
  lesson: lesson_6,
  position_in_lesson: 4,
  question_en: "B ⊂ (A ∪ C) \n\n" \
    "B ⊄ (A ⋂ C) \n\n" \
    "C ⊄ B \n\n" \
    "Does B ⊂ A ?",
  answer: 'true'
)

Exercise.create(
  lesson: lesson_6,
  position_in_lesson: 5,
  question_en: "A ⊂ (B ⋂ C) \n\n" \
    "(B ∪ C) ⊂ A\n\n" \
    "Does A = B = C ?",
  answer: 'true'
)

Exercise.create(
  lesson: lesson_6,
  position_in_lesson: 6,
  question_en: "If (A ∪ B) ⊂ (A ∪ C) \n\n" \
    "And (A ⋂ B) ⊂ (A ⋂ C) \n\n" \
    "Does B ⊂ C?",
  answer: 'true'
)

###############################################################################

lesson_7 = Lesson.create(
  chapter: chapter_1,
  position_in_chapter: 7,
  title_en: 'Complement of sets',
  content_en: "The complement of a set contained inside another set is a third set containing \n\n" \
  "all elements of the containing set that do not belong to the contained set. \n\n" \
  "* Its symbol is ∁, which means that for a set A contained inside a set B, the \n\n" \
  "complement of A inside B is written -> ∁ᴬʙ \n\n" \
  "* You can also write it with an overline like this : for a set X, its complement is X̅ \n\n" \
  "* You can also write it simply like this : Aᶜ, knowing that we are in the context of B\n\n" \
  "* A set and its complement are always disjoints : X ⋂ X̅ = ø \n\n" \
  "* A set and its complement, if united, are complementary inside another set : A ∪ ∁ᴬʙ = B \n\n" \
  "* The complement of a complement is always itself : for a set O, o̿ = O. \n\n" \
  "* The first law of Morgan stipulates the following : The complement of the " \
  "union of two sets is always the intersection of their mutual complements. " \
  "Which means (A ∪ B)ᶜ = Aᶜ ⋂ Bᶜ. \n\n" \
  "* The second law of Morgan stipulates the following : The complement of the " \
  "intersection of two sets is the union of their complements; "\
  "which means (A ⋂ B)ᶜ = (Aᶜ ∪ Bᶜ)"
)

Example.create(
  lesson: lesson_7,
  position_in_lesson: 1,
  content_en: "B = { 3 } \n\n" \
    "G = { 2 ; 3 ; 4 } \n\n" \
    "M = { 1 ; 2 ; 3 ; 4 ; 5 } \n\n" \
    "Here you can see that B ⊂ G ⊂ M \n\n" \
    "And ∁ᴮᴍ = { 1 ; 2 ; 4 ; 5 } \n\n" \
    "But ∁ᴮɢ = { 2 ; 4 } \n\n",
  img_url: 'maths_for_cs/chapter_1/lesson_7/example_1.png'
)

Example.create(
  lesson: lesson_7,
  position_in_lesson: 2,
  content_en: "B = { 3 ; 4 ; 6 } \n\n" \
    "G = { 1 ; 2 ; 3 ; 4 ; 5 ; 6 ; 7 } \n\n" \
    "∁ᴮɢ = { 1 ; 2 ; 5 ; 7 } \n\n" \
    "Here the cardinal of B, |B| = 3 \n\n" \
    "Also the cardinal of ∁ᴮɢ, |∁ᴮɢ| = 4 \n\n" \
    "Therefore, |G| = |B| + |∁ᴮɢ| = 3 + 4 = 7 \n\n",
)

Example.create(
  lesson: lesson_7,
  position_in_lesson: 3,
  content_en: "Let's consider a set E = { 1 ; 2 ; 3 ; 4 ; 5 ; 6 ; 7 } \n\n" \
    "A = { 3 ; 4 } \n\n" \
    "B = { 1 ; 2 ; 3 } \n\n" \
    "We can easily see that A ∪ B = { 1 ; 2 ; 3 ; 4 } \n\n" \
    "Therefore (A ∪ B)ᶜ = { 5 ; 6 ; 7 } \n\n" \
    "Also, within E, Aᶜ = { 1 ; 2 ; 5 ; 6 ; 7 } ; \n\n" \
    "And Bᶜ = { 4 ; 5 ; 6 ; 7 } \n\n" \
    "Therefore, according to the first law of Morgan, \n\n" \
    "Aᶜ ⋂ Bᶜ = { 5 ; 6 ; 7 }, which is equal to (A ∪ B)ᶜ",
  img_url: 'maths_for_cs/chapter_1/lesson_7/example_3.png'
)

Example.create(
  lesson: lesson_7,
  position_in_lesson: 4,
  content_en: "Let's take the same example as above ; \n\n" \
    "We can easily see that A ⋂ B = { 3 } \n\n" \
    "Therefore (A ⋂ B)ᶜ = { 1 ; 2 ; 4 ; 5 ; 6 ; 7 } \n\n" \
    "Also, within E, Aᶜ = { 1 ; 2 ; 5 ; 6 ; 7 } ; \n\n" \
    "And Bᶜ = { 4 ; 5 ; 6 ; 7 } \n\n" \
    "Therefore, according to the first law of Morgan, \n\n" \
    "Aᶜ ∪ Bᶜ = { 1 ; 2 ; 4 ; 5 ; 6 ; 7 }, which is equal to (A ⋂ B)ᶜ",
  img_url: 'maths_for_cs/chapter_1/lesson_7/example_4.png'
)

Exercise.create(
  lesson: lesson_7,
  position_in_lesson: 1,
  question_en: "A = { 1 ; 2 } \n\n" \
    "B = { 2 ; 4 } \n\n" \
    "is P(A) ⋂ P(B) = P(A ⋂ B) ?",
  answer: 'true'
)

Exercise.create(
  lesson: lesson_7,
  position_in_lesson: 2,
  question_en: "A = { 1 ; 2 ; 3 } \n\n" \
    "B = { 2 ; 4 } \n\n" \
    "Is P(A ∪ B) = P(A) ∪ P(B) ?",
  answer: 'false'
)

Exercise.create(
  lesson: lesson_7,
  position_in_lesson: 3,
  question_en: "A = { 1 ; 2 ; 3 ; 4 ; 5 } \n\n" \
    "B = { 2 ; 3 } \n\n" \
    "C = { 4 ; 5 } \n\n" \
    "Define, (B ∪ C)ᶜ within A",
  answer: '{ 1 }'
)

Exercise.create(
  lesson: lesson_7,
  position_in_lesson: 4,
  question_en: "Within a set E containing all letters of the english alphabet \n\n" \
    "A = { a ; b ; c ; d ; e } and B = { b ; d ; e ; f ; g } \n\n" \
    "Does b ∈ (A ⋂ Bᶜ) within E?\n\n",
  answer: 'false'
)

Exercise.create(
  lesson: lesson_7,
  position_in_lesson: 5,
  question_en: "Within a set E containing all letters of the english alphabet \n\n" \
    "A = { a ; b ; c ; d ; e } and B = { b ; d ; e ; f ; g } \n\n" \
    "Does { a ; c } ⊂ (A ⋂ Bᶜ) ?\n\n",
  answer: 'true'
)


###############################################################################
user = User.create(
  email: 'pierre.hersant@gmail.com',
  password: 'azertyuiopmlkjhgffdsq'
)

###############################################################################
Course.create(
  title_en: "Algorithms",
  description_en: "Understand and learn to choose the best algorithms for each use case"
)

Course.create(
  title_en: "Computer Science",
  description_en: "Understand the basic of computer science"
)

Course.create(
  title_en: "Software architecture",
  description_en: "Understand the basic of software architecture"
)

Course.create(
  title_en: "Cryptography",
  description_en: "Learn how to protect data with this cryptography course"
)

Course.create(
  title_en: "Blockchain",
  description_en: "Learn how blockchain works by build them"
)

Course.create(
  title_en: "Machine Learning",
  description_en: "Learn how to use machine learning"
)

Course.create(
  title_en: "Data science and data engineering",
  description_en: "Learn Data Science and the difference with data engineering"
)
