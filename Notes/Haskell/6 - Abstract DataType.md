# 6 - Abstract DataType

Até agora lidamos com tipos de dados concretos porque se começa por definir a representação dos dados mas não quaisquer operações. Exemplos:

```haskell
data Bool = False | True
data Nat = Zero | Succ Nat
```

Na representação abstrata, começamos por especificar as operações, omitindo a representação concreta dos dados. 

## Tipos de dados abstratos

### Pilhas 

Terá de ter operações de push, pop, top, empty e isEmpty. 

```haskell
data Stack a -- pilha com valores de tipo ‘a’
push :: a -> Stack a -> Stack a
pop :: Stack a -> Stack a
top :: Stack a -> a
empty :: Stack a
isEmpty :: Stack a -> Bool
```

Para implementar um tipo abstrato escolhemos uma representação concreta para as operações e dizemos apenas como usar o tipo e as operações válidas. Para isso podemos usar `módulos`:

```haskell
module Post where -- no topo do ficheiro, para criar o módulo
import Post (Function1, Function2) -- no topo do ficheiro que usa o módulo
```

### Conjuntos

Terá de ter as operações member, insert, delete, union, inserction, empty, isEmpty, fromList, toList.

```haskell
data Set a = Empt | Node a (Set a) (Set a)
```