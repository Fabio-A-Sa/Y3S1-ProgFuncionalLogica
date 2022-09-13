-- Hello World in Haskell
hello_world = print "Hello world!"

-- A simple function that prints the sum of squares
anotherFunction = print (sum (map (^2) [1..10]))

-- Composição de funções
dobro x = 2*x
quadruplo x = dobro (dobro x)

-- Factorial
factorial n = product [1..n]

-- Quick sort
qsort :: (Ord a) => [a] -> [a]
qsort = \list ->
      case list of
          [] -> []
          x:xs -> qsort left ++ [x] ++ qsort right
              where left = [x1 | x1 <- xs, x1 <= x]
                    right = [x2 | x2 <- xs, x2 > x]

-- main = function to run
main = print (qsort [5, 2, 3, 4, -1, 0, 6, 200, -3, -3, 23, 5, -2, 0])
