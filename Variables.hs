-- module Variables (bin2bool, listVar) where

-- import Table (Exp (Var, Not, And, Or))

-- bin2bool = \bin ->
  -- if bin == 0 then
    -- False
  -- else
    -- True

-- dec2bin number len = fill (baseShift number 2) len

-- baseShift number base
  -- | number < base = [number]
  -- | otherwise = baseShift (div number base) base ++ [mod number base]

-- listVar (Var var) = [var]
-- listVar (Not expression) = listVar expression
-- listVar (And e1 e2) = listVar e1 ++ listVar e2
-- listVar (Or  e1 e2) = listVar e1 ++ listVar e2

-- fill list n
  -- | length list < n = 0 : fill list (n-1)
  -- | otherwise = list