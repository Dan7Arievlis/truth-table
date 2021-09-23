module EvaluateExpression (evaluate) where

import Stack (Stack, new, push, pop, isEmpty)

evaluate expression = evaluate' new expression

evaluate' stack [] =
  if isEmpty stack then
    return True
  else
    return False
evaluate' stack (c:s)
  | c == '(' = evaluate' (push stack '(' ) s
  | c == ')' = evaluate' (snd (pop stack)) s
  | otherwise = evaluate' stack s
