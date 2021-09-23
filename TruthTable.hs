module TruthTable where

import EvaluateExpression (evaluate)

data Exp = String | Var String | Not Exp | And Exp Exp | Or Exp Exp deriving (Show, Read, Eq)

data Set = Empty | Node Set (String, Bool) Set deriving (Show)

new = Empty

main = 
  do
    putStrLn ("\nINSTRUCOES\n" ++ 
              "Nao = Not (Formula)\n" ++ 
              "E = And (Formula 1) (Formula 2)\n" ++ 
              "Ou = Or (Formula 1) (Formula 2)\n" ++ 
              "Variavel* = Var Nome\n\n" ++ 
              "* Variaveis devem ser nomeadas com apenas um caracter e sem uso de aspas simples ou duplas\n")
    putStr "Digite uma expressao booleana seguindo as instrucoes acima (para sair, aperte ENTER): \n  > "
    str <- getLine
    if str /= "" then 
      do 
        verify <- evaluate str
        if verify then
          truthTable (read (format str []) :: Exp)
        else
          do
            putStrLn "\n----------------------------------------------------\n"
            putStrLn ("*** Numero de parenteses incompativel ***\n" ++ 
                      "            Tente novamente")
            main
    else 
      putStrLn "Saindo"

truthTable expression =
  do
    putStrLn ("\nTabela verdade: \n\n" ++ printTab)
    putStrLn ("\nTautologia: " ++ show (isTautology table) ++ "\n")
    putStrLn "----------------------------------------------------"
    main
      where
          len = tamanho set
          set = addAll list new False
          list = listVar expression
          table = makeTable expression (2^len) len set
          printTab = printTable expression table set

-- INPUT E OUTPUT

format "" _ = ""
format (c:s) word
  | word == "Var " = "\"" ++ [c] ++ "\"" ++ format s ""
  | c == '(' = [c] ++ format s ""
  | otherwise = [c] ++ format s (word ++ [c])

printTable str table set = printHeader set ++ printExp str ++ "\n" ++ printBody table

printHeader Empty = ""
printHeader (Node setL (a,b) setR) = printHeader setL ++ chart a 5 ++ "  |  " ++
                                     printHeader setR

printBody [] = ""
printBody (((a:b),c):d) = printInput (a:b) ++ chart (show c) 5 ++ "\n" ++ printBody d

printInput [] = ""
printInput (a:b) = chart (show a) 5 ++ "  |  " ++ printInput b

chart str n
  | n <= length str = str
  | otherwise = chart str (n-1) ++ " "

printExp (Var var) = var
printExp (Not expression) = "~(" ++ printExp expression ++ ")"
printExp (Or  e1 e2) = "(" ++ printExp e1 ++ ")+(" ++ printExp e2 ++ ")"
printExp (And e1 e2) = "(" ++ printExp e1 ++ ").(" ++ printExp e2 ++ ")"

-- TRATO DE CONDICOES

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

-- TABELA

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

-- SET

add var Empty bool = Node Empty (var,bool) Empty
add var (Node setL (a,b) setR) bool
  | var > a = Node setL (a,b) (add var setR bool)
  | var < a = Node (add var setL bool) (a,b) setR
  | otherwise = Node setL (a,bool) setR

addAll [e] set bool = add e set bool
addAll (a:b) set bool = add a (addAll b set bool) bool

tamanho Empty = 0
tamanho (Node setL (a,b) setR) = tamanho setL + 1 + tamanho setR

getBool var (Node setL (a,b) setR)
  | var > a = getBool var setR
  | var < a = getBool var setL
  | otherwise = b