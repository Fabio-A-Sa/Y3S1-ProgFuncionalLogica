type Coeficient = Int
type Symbol = [Char]
type Exponent = Int
type Monomial = (Coeficient, [(Symbol, Exponent)])
type Polynomial = [Monomial]

normalize :: Polynomial -> Polynomial
normalize polynomial = polynomial

deriveMonomial :: Monomial -> Symbol -> Monomial
deriveMonomial monomial symbol = monomial

derivePoly :: Polynomial -> Symbol -> Polynomial
derivePoly polynomial symbol = normalize ([deriveMonomial monomial symbol | monomial <- polynomial])

split :: String -> [String]
split [] = []
split string = f : split rest 
  where (f, rest) = break (\c -> c == '+' || c == '-') (dropWhile (\c -> c == '+' || c == '-') string) 

parse :: String -> [String]
parse string = split $ filter (/= ' ') string