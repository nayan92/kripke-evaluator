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
evaluate m w ( Not f )
  = not ( evaluate m w f )
evaluate m w ( And f f' )
  = ( evaluate m w f ) && ( evaluate m w f' )
evaluate m@( n, r, _ ) w ( Box f )
  = and ( map evaluate' n )
  where
    evaluate' w'
      = ( not ( elem ( w, w' ) r ) ) || ( evaluate m w' f )
evaluate m w ( Diamond f )
  = evaluate m w ( Not ( Box ( Not f ) ) )