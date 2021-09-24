module TruthTable where

import Conditions (listVar)
import EvaluateExpression (evaluate)
import IO (format, printTable)
import Set (new, size, addAll)
import Table (makeTable)

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
    putStrLn "Digite uma expressao booleana seguindo as instrucoes acima (para sair, aperte ENTER): "
    putStr   "  > "
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
          len = size set
          set = addAll list new False
          list = listVar expression
          table = makeTable expression (2^len) len set
          printTab = printTable expression table set
