module Table (makeTable) where

import Set (getBool)

makeTable expression 0 len set = []
makeTable expression n len set = [(io,evaluateExp line expression)] ++ makeTable expression (n-1) len set
  where
    io = map bin2bool (dec2bin (n-1) len)
    listSet = toList set
    newList = attribute io listSet
    line = newSet newList set

toList Empty = []
toList (Node setL (a,b) setR) = toList setL ++ [(a,b)] ++ toList setR

attribute [] _ = []
attribute (a:b) ((var,bool):c) = (var,a) : attribute b c

newSet [] set = set
newSet ((a,b):c) set = newSet c (add a set b)

evaluateExp set (Var var) = getBool var set
evaluateExp set (Not ex) = not (evaluateExp set ex)
evaluateExp set (Or  e1 e2) = (evaluateExp set e1) || (evaluateExp set e2)
evaluateExp set (And e1 e2) = (evaluateExp set e1) && (evaluateExp set e2)

isTautology = foldl (&&) True . map snd
