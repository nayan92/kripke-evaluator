----------------------
-- Kripke Evaluator --
----------------------

type Atom = String

data Formula = Var Atom | TrueT | FalseT | Not Formula | And Formula Formula
               | Or Formula Formula | Box Formula | Diamond Formula
               | Implies Formula Formula

type Node = String
type World = [ Node ]
type Relation = [ ( Node, Node ) ]
type Valuation = [ ( Atom, Node ) ]

type Model = ( World, Relation, Valuation )

evaluate :: Model -> Node -> Formula -> Bool
-- Case when (M, w) |= true
evaluate _ _ TrueT
  = True
-- Case when (M, w) |= p
evaluate ( _, _, val ) w ( Var v )
  = elem w $ snd $ unzip $ filter matches val
  where
    matches ( v', _ )
      = v' == v
-- Case when (M, w) |= not f
evaluate m w ( Not f )
  = not ( evaluate m w f )
-- Case when (M, w) |= f and f'
evaluate m w ( And f f' )
  = ( evaluate m w f ) && ( evaluate m w f' )
-- Case when (M, w) |= f or f'
evaluate m w ( Or f f' )
  = ( evaluate m w f ) || ( evaluate m w f' )
-- Case when (M, w) |= box f
evaluate m@( n, r, _ ) w ( Box f )
  = and ( map evaluate' n )
  where
    evaluate' w'
      = ( not $ elem ( w, w' ) r ) || ( evaluate m w' f )
-- Case when (M, w) |= diamond f
evaluate m w ( Diamond f )
  = evaluate m w ( Not ( Box ( Not f ) ) )
-- Case when (M, w) |= f -> f'
evaluate m w ( Implies f f' )
  = ( not $ evaluate m w f ) || ( evaluate m w f' )
-- Case else
evaluate _ _ _
  = False
