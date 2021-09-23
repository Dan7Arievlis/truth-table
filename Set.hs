module Set (add, addAll, size, getBool) where

add var Empty bool = Node Empty (var,bool) Empty
add var (Node setL (a,b) setR) bool
  | var > a = Node setL (a,b) (add var setR bool)
  | var < a = Node (add var setL bool) (a,b) setR
  | otherwise = Node setL (a,bool) setR

addAll [e] set bool = add e set bool
addAll (a:b) set bool = add a (addAll b set bool) bool

size Empty = 0
size (Node setL (a,b) setR) = size setL + 1 + size setR

getBool var (Node setL (a,b) setR)
  | var > a = getBool var setR
  | var < a = getBool var setL
  | otherwise = b
