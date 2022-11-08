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

-- Média de uma lista usando casting
media :: Fractional a => [a] -> a
media list = sum list / fromIntegral(length list)

-- Raízes segundo a fórmula resolvente
raizes :: Float -> Float -> Float -> [Float]
raizes a b c
            | delta>0 = [(-b+sqrt delta)/(2*a), (-b-sqrt delta)/(2*a)]
            | delta==0 = [-b/(2*a)]
            | otherwise = []
        where delta = b^2 - 4*a*c

-- main = function to run
main = print (raizes 1 2 0)
