module Set (Set (Empty, Node), new, add, addAll, size, getBool, toList) where

data Set = Empty | Node Set (String, Bool) Set deriving (Show)

new = Empty

add var Empty bool = Node Empty (var,bool) Empty
add var (Node setL (a,b) setR) bool
  | var > a = Node setL (a,b) (add var setR bool)
  | var < a = Node (add var setL bool) (a,b) setR
  | otherwise = Node setL (a,bool) setR

addAll [e] set bool = add e set bool
addAll (a:b) set bool = add a (addAll b set bool) bool

size Empty = 0
size (Node setL (a,b) setR) = size setL + 1 + size setR

toList Empty = []
toList (Node setL (a,b) setR) = toList setL ++ [(a,b)] ++ toList setR

getBool var (Node setL (a,b) setR)
  | var > a = getBool var setR
  | var < a = getBool var setL
  | otherwise = b
