# truth-table

Código que transforma a entrada de uma fórmula enviada com n variáveis numa tabela verdade e se a expressão é uma tautologia.

A entrada deve obedecer uma série de instruções para ser admitida e processada:

  Não: Not exp1 exp2
  E: And exp1 exp2
  Ou: Or exp1 exp2
  Variáveis*: Var Nome
  
  * Nomes de variáveis devem ter apenas um caracter e não podem conter aspas simples ou duplas

```INSTRUCOES
Nao = Not (Formula)
E = And (Formula 1) (Formula 2)
Ou = Or (Formula 1) (Formula 2)
Variavel* = Var Nome

* Variaveis devem ser nomeadas com apenas um caracter e sem uso de aspas simples ou duplas

Digite uma expressao booleana seguindo as instrucoes acima (para sair, aperte ENTER):
  > Or (Var C) (And (Var B) (Not (Var A)))  -- input

Tabela verdade:

A      |  B      |  C      |  (C)+((B).(~(A)))
True   |  True   |  True   |  True
True   |  True   |  False  |  False
True   |  False  |  True   |  True
True   |  False  |  False  |  False
False  |  True   |  True   |  True
False  |  True   |  False  |  True
False  |  False  |  True   |  True
False  |  False  |  False  |  False


Tautologia: False

----------------------------------------------------