# Data Types

## Declaração de sinónimos

Haskell permite declarar novos tipos de variáveis com base em outras pré-existentes. Não podem ser usadas recursivamente.

```haskell
type String = [Char] -- do Prelúdio-padrão
type position (Int, Int)
type cels = [position]
type Association key value = [(key, value)]
idades :: Assocication String Int
type Tree = (Int, [Tree]) -- Erro: não permite recursão
```

## Declaração de novos tipos

Para novos tipos de variáveis, declarar como `data`. Por omissão, os novos tipos não têm instâncias de classes como Show, Eq ou Ord.

```haskell
data Direction = Esquerda | Direita | Cima | Baixo
direções = [Direction] -- == [Esquerda, Direita, Baixo, Cima]
oposta :: Direction -> Direction
oposta Esquerda = Direita -- ...
```

### Construtores

Por omissão, os novos tipos não têm instâncias de classes como Show, Eq ou Ord, mas podemos derivar os métodos de acordo com os tipos primitivos, que já estão definidos no prelude padrão.

```haskell
data Figura = Circle Float
            | Rectangle Float Float
              deriving (Eq, Show) -- deriva os métodos Eq e Show dos argumentos do novo tipo

area :: Figura -> Float
area (Circle r) = pi * r * r
area (Rectangle l a) = l * a

data Maybe a = Nothing | Just a
savediv :: Int -> Int -> Maybe Int
savediv a 0 = Nothing
savediv a x = div a x
```

### Tipos recursivos

```haskell
data Natural = Zero | Suc Natural -- 3 = suc (suc (suc 0))
natFromInt :: Int -> Natural
natFromInt 0         = Zero
natFromInt n | n > 0 = Suc (natFromInt (n-1))
```

## Árvores

### Árvores sintáticas

```haskell
data Expression = Value Int                   -- Constante
                | Soma Expression Expression   -- Soma
                | Mult Expression Expression  -- Multiplicação

-- 1+2*3
-- Soma (Value 1) (Mult (Value 2) (Value 3))

calcula :: Expression -> Int
calcula (Value x) = x
calcula (Soma x1 x2) = Value x1 + Value x2
calcula (Mult x1 x2) = Value x1 * Value x2
```

### Árvores binárias (de pesquisa)

```haskell
data Tree  = Node Int BTree BTree   -- nó
           | Folha                  -- folha

listar :: Tree a -> [a]
listar Vazia = []
listar (Node x Tree_esq Tree_dir) = list Tree_esq ++ [x] ++ Tree_dir

procurar :: Ord a => a -> Arv a -> Bool
procurar x Vazia = False        -- não ocorre
procurar x (No y esq dir)
        | x==y = True           -- encontrou
        | x<y = procurar x esq  -- procura à esquerda
        | x>y = procura x dir   -- procura à Direita

inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
        | x==y = No y esq dir             -- já ocorre; não insere
        | x<y = No y (inserir x esq) dir  -- insere à esquerda
        | x>y = No y esq (inserir x dir)  -- insere à direita

construir :: [a] -> Arv a
construir [] = Vazia
construir xs = No x (construir xs’) (construir xs”)
  where   n = length xs‘div‘2           -- ponto médio
          xs’ = take n xs               -- partir a lista
          x:xs” = drop n xs

remover :: Ord a => a -> Arv a -> Arv a
remover x Vazia = Vazia                   -- não ocorre
remover x (No y Vazia dir)                -- um descendente
        | x==y = dir
remover x (No y esq Vazia)                -- um descendente
        | x==y = esq
remover x (No y esq dir)                  -- dois descendentes
        | x<y = No y (remover x esq) dir
        | x>y = No y esq (remover x dir)
        | x==y = let z = maisEsq dir
                 in No z esq (remover z dir)
```