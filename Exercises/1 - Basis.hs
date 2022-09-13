-- Hello World in Haskell
hello_world = print "Hello world!"

-- A simple function that prints the sum of squares
anotherFunction = print (sum (map (^2) [1..10]))

-- Composição de funções
dobro x = 2*x
quadruplo x = dobro (dobro x)

-- main = function to run
main = print (quadruplo 5)
