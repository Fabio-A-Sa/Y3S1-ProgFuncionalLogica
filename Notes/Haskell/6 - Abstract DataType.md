# 6 - Abstract DataType

Até agora lidamos com tipos de dados concretos porque se começa por definir a representação dos dados mas não quaisquer operações. Exemplos:

```haskell
data Bool = False | True
data Nat = Zero | Succ Nat
```

Na representação abstrata, 