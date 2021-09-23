module IO (format, printTable) where

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
