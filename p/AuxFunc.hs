module AuxFunc where

unique :: Eq a => [a] -> [a] -- Receives a list and returns it with no duplicates
unique [] = []
unique (x:xs) = x:unique (filter (/= x) xs)

addSpaces :: String -> String -- Adds spaces around all signals (+ or -) in a given string
addSpaces [] = []
addSpaces str = foldr (\ x -> (++) (if x == '+' || x == '-' then " " ++ [x] ++ " " else [x])) [] str

makeReadable :: String -> String -- Makes a polynomial in string format more readable by adding some spaces
makeReadable ('-':xs) = "-" ++ makeReadable xs
makeReadable str = addSpaces str

removeLast :: [a] -> [a] -- Removes the last element of a list
removeLast [] = []
removeLast [h] = []
removeLast (h:t) = h : removeLast t

isSignal :: Char -> Bool -- Checks if a a character is either '+' or '-'
isSignal char = char == '-' || char == '+'

removePlus :: String -> String -- Removes the plus signal at the beginning of a given monomial/polynomial in string format
removePlus string = if head string == '+' then drop 1 string else string

split :: String -> Char -> [String] -- Splits the string by the given character
split [] _ = []
split string char = left : split right char
  where (left, right) = break (== char) (dropWhile (== char) string) 

splitSignal :: String -> [String] -- Splits the string by signals (+ or -)
splitSignal [] = []
splitSignal string = left : splitSignal right
  where left = takeWhile isSignal string ++ takeWhile (not.isSignal) (dropWhile isSignal string)
        right = dropWhile (not.isSignal) (dropWhile isSignal string)