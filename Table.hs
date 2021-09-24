module Table (Exp, makeTable, printExp, listVar, isTautology) where

import Set (Set, getBool, toList, add)

data Exp = String | Var String | Not Exp | And Exp Exp | Or Exp Exp deriving (Show, Read, Eq)

makeTable expression 0 len set = []
makeTable expression n len set = [(io,evaluateExp line expression)] ++ makeTable expression (n-1) len set
  where
    io = map bin2bool (dec2bin (n-1) len)
    listSet = toList set
    newList = attribute io listSet
    line = newSet newList set

attribute [] _ = []
attribute (a:b) ((var,bool):c) = (var,a) : attribute b c

newSet [] set = set
newSet ((a,b):c) set = newSet c (add a set b)

evaluateExp set (Var var) = getBool var set
evaluateExp set (Not ex) = not (evaluateExp set ex)
evaluateExp set (Or  e1 e2) = (evaluateExp set e1) || (evaluateExp set e2)
evaluateExp set (And e1 e2) = (evaluateExp set e1) && (evaluateExp set e2)

printExp (Var var) = var
printExp (Not expression) = "~(" ++ printExp expression ++ ")"
printExp (Or  e1 e2) = "(" ++ printExp e1 ++ ")+(" ++ printExp e2 ++ ")"
printExp (And e1 e2) = "(" ++ printExp e1 ++ ").(" ++ printExp e2 ++ ")"

isTautology = foldl (&&) True . map snd

-- Variaveis

bin2bool = \bin ->
  if bin == 0 then
    False
  else
    True

dec2bin number len = fill (baseShift number 2) len

baseShift number base
  | number < base = [number]
  | otherwise = baseShift (div number base) base ++ [mod number base]

listVar (Var var) = [var]
listVar (Not expression) = listVar expression
listVar (And e1 e2) = listVar e1 ++ listVar e2
listVar (Or  e1 e2) = listVar e1 ++ listVar e2

fill list n
  | length list < n = 0 : fill list (n-1)
  | otherwise = list