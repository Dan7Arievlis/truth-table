module Stack (Stack, new, isEmpty, push, pop, peek, contains, search) where

data Stack t = Stack [t] deriving Show

new :: Stack t
new = Stack []

isEmpty :: Stack t -> Bool
isEmpty (Stack []) = True
isEmpty _  = False

push :: Stack t -> t -> Stack t
push (Stack stack) elem = Stack (elem : stack)

pop :: Stack t -> (t, Stack t)
pop (Stack []) = error "Pilha vazia"
pop (Stack (a:b)) = (a, Stack b)

peek :: Stack t -> t
peek (Stack (a:b)) = a

contains :: (Eq t) => Stack t -> t -> Bool
contains (Stack []) value = False
contains (Stack (a:b)) value
  | a == value = True
  | otherwise = contains (Stack b) value

search :: (Eq t) => Stack t -> t -> Int
search (Stack stack) value = search' stack value 0

search' [] value index = error "Item nao encontrado"
search' (a:b) value index
  | value == a = index
  | otherwise = search' b value (succ index)