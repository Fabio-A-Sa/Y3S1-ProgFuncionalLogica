module Polynom where

import Data.Char
import Data.List
import AuxFunc

type Coefficient = Int
type Exponent = Int
type Symbol = Char
type Monomial = (Coefficient, [(Symbol, Exponent)])
type Polynomial = [Monomial]

-- === NORMALIZE ===

normalize :: String -> String       -- Receives a polynomial in string format, normalizes it, and returns the result in string format
normalize str = polyToString $ normalizePoly $ parsePoly str

normalizePoly :: Polynomial -> Polynomial    -- Receives a polynomial in our internal representation and returns the result in another internal representation
normalizePoly polynomial = if (not.null) normalized then normalized else [(0,[])]
      where normalized = sortBy (\x y -> compare (getDegree y) (getDegree x)) $ filter (\x -> fst x /= 0) $ foldl doAllSums (getUniqueTerms polynomial) polynomial

doAllSums :: Polynomial -> Monomial -> Polynomial     -- Tries to sum a monomial to each element of the given polynomial, returns the resultant polynomial
doAllSums poli mono = [addMonomial mono2 mono| mono2 <- poli]

getUniqueTerms :: Polynomial -> Polynomial -- Returns all unique terms of the polynomial with coefficients equal to 0, sorted by degree, as a new polynomial
getUniqueTerms polynomial = unique [(0, sortBy sortExponents (snd monomial)) | monomial <- polynomial]

addMonomial :: Monomial -> Monomial -> Monomial -- Returns the sum of two monomials if their literal parts are equal, returns the first monomial otherwise
addMonomial (coefficient1, exponents1) (coefficient2, exponents2) = 
      if (==) (sortBy sortExponents exponents1) (sortBy sortExponents exponents2) then (coefficient1 + coefficient2, exponents1) else (coefficient1, exponents1)

sortExponents :: (Ord a, Ord b) => (a, b) -> (a, b) -> Ordering -- Sort exponents by alphabetic order
sortExponents (c1, _) (c2, _)
  | c1 > c2 = GT
  | c1 < c2 = LT
  | c1 == c2 = EQ

getDegree :: Monomial -> Int -- Returns the degree of the monomial
getDegree monomial = sum [snd x | x <- snd monomial]

-- === DERIVE ===

deriveMonomial :: Symbol -> Monomial -> Monomial -- Derives a monomial in respect to the given symbol
deriveMonomial _ (_, []) = (0,[])
deriveMonomial symbol (coef, exps) = if exp /= -1 then (coef * exp, newExps) else (0,[])
      where exp = foldl (\acc x -> if fst x == symbol then snd x else if acc /= -1 then acc else (-1)) (-1) exps
            newExps = [(s, if s == symbol then e-1 else e) | (s, e) <- exps, s/=symbol || ((s == symbol) && (e-1 /= 0))]

derivePoly :: Symbol -> Polynomial -> Polynomial -- Derives a polynomial in respect to the given symbol
derivePoly symbol polynomial = normalizePoly [deriveMonomial symbol monomial | monomial <- polynomial]

derive :: Symbol -> String -> String -- Derives a polynomial in string format in respect to the given symbol, then also returns it in string format
derive symbol str = polyToString $ derivePoly symbol $ parsePoly str

-- === ADD ===

add :: String -> String -> String -- Adds two polynomials in string format, then also returns the result in string format
add string1 string2 = polyToString $ normalizePoly (polynomial1 ++ polynomial2)
      where polynomial1 = parsePoly string1
            polynomial2 = parsePoly string2

-- === MULTI ===

multiExponents :: [(Symbol, Exponent)] -> [(Symbol, Exponent)] -> [(Symbol, Exponent)] -- Multiplies two sets of exponents in internal representation format
multiExponents terms1 terms2 = filter (not.null) $ foldl (\acc x -> [if fst x == fst z then (fst x, snd x + snd z) else z | z <- acc]) (getUniqueSymbols terms1 terms2) (terms1 ++ terms2)

getUniqueSymbols :: [(Symbol, Exponent)] -> [(Symbol, Exponent)] -> [(Symbol, Exponent)]  -- Receives to lists of variables and their exponents, returns a single lists with all the unique variables of both lists, with every exponent equal to 0
getUniqueSymbols terms1 terms2 = unique [(fst v, 0) | v <- terms1 ++ terms2]

multiMonomial :: Monomial -> Monomial -> Monomial -- Multiplies two monomiais in internal representation format 
multiMonomial (coefficient1, exponents1) (coefficient2, exponents2) = (coefficient1 * coefficient2, multiExponents exponents1 exponents2)

multi :: String -> String -> String -- Multiplies two polynomials in string format, then also returns the result in string format
multi string1 string2 = polyToString $ normalizePoly [multiMonomial monomial1 monomial2 | monomial1 <- polynomial1, monomial2 <- polynomial2]
      where polynomial1 = parsePoly string1
            polynomial2 = parsePoly string2

-- ======= Parser =======

formatVariables :: String -> (Symbol, Exponent) -- Turns a string "Symbol^Exponent" or "Symbol" into a pair (Symbol,Exponent) or (Symbol,1) respectively.
formatVariables [x] = (x, 1)
formatVariables (x:xs) = (x, read (dropWhile (\x -> isLetter x || x == '^') xs) :: Int)

formatLitPart :: String -> [(Symbol, Exponent)] -- Turns every string "Symbol^Exponent" or "Symbol" into a list of pairs (Symbol,Exponent) or (Symbol,1) respectively.
formatLitPart "" = []
formatLitPart string = [formatVariables term | term <- split string '*']

toMonomial :: String -> Monomial -- Converts a given string into our internal Monomial format
toMonomial "" = (0,[])
toMonomial string = (coefficient, exponents)
  where coefficient
            | not (null aux) && aux /= "-" = read aux :: Int
            | aux == "-" = - 1
            | otherwise = 1
        exponents = formatLitPart (dropWhile (\x -> x == '-' || isDigit x || x == '*') string)
        aux = takeWhile (\x -> x == '-' || isDigit x) string

parsePoly :: String -> Polynomial -- Converts a given string into our internal Polynomial format
parsePoly string = map (toMonomial . removePlus) (splitSignal $ filter (not . isSpace) string)

polyToString :: Polynomial -> String -- Converts a Polynomial in our internal format into a string.
polyToString [] = []
polyToString polynomial = makeReadable $ if head polyString == '+'
                              then tail polyString
                              else polyString
      where polyString = foldl (\acc x -> acc ++ monoToString x) [] polynomial

monoToString :: Monomial -> String -- Converts a Monomial in our internal format into a string.
monoToString (coefficient, litPart) = coef ++ litPartString
      where coef = if litPartString/="" then 
                  case str of 
                        "-1" -> "-"
                        "+1" -> "+"
                        _ -> str
                  else str
            litPartString = removeLast $ litPartToString litPart
            str = if coefficient < 0 then show coefficient else "+" ++ show coefficient

litPartToString :: [(Symbol, Exponent)] -> String -- Converts the literal part of a monomial in our internal representation into a string
litPartToString [] = []
litPartToString (x:xs) = [fst x] ++ exp ++ "*" ++ litPartToString xs
      where exp = if snd x > 1 then "^" ++ show (snd x) else ""