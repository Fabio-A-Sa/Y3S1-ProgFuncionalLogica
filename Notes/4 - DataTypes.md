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
data Tree = Node Tree Tree
          | Folha Int

data BTree x = Node x BTree BTree -- nó
           | Vazia              -- folha

listar :: BTree a -> [a]
listar Vazia = []
listar (Node x BTree_esq BTree_dir) = list BTree_esq ++ [x] ++ BTree_dir

#TODO
```