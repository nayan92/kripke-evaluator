import Data.Maybe

type Atom = String
data Formula = Var Atom | TrueT | FalseT | Not Formula | And Formula Formula | Box Formula | Diamond Formula
  deriving (Eq, Ord, Show)

type Node = String
type Nodes = [ Node ]
--type Variables = [ Atom ]
type Relation = [ ( Node, Node ) ]
type Valuation = [ ( Atom, Node ) ]

type Model = ( Nodes, Relation, Valuation )

evaluate :: Model -> Node -> Formula -> Bool
evaluate _ _ TrueT
  = True
evaluate ( _, _, val ) w ( Var v )
  = elem w ( snd ( unzip ( filter matches val ) ) )
  where
    matches ( v', _ )
      = v' == v
