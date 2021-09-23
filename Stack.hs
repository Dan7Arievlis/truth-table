module Stack (Stack, new, pop, push, isEmpty) where

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
