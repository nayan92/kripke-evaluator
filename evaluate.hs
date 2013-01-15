data Atom = Var String

data Formula = Atom | True | Not Formula | And Formula Formula | Box Formula | Diamond Formula

type Node = String
type Nodes = [ Node ]
type Variables = [ Atom ]
type Relation = [ ( Node, Node ) ]
type Valuation = [ ( Atom, Node ) ]

type Model = ( Nodes, Relation, Valuation )

--evaluate :: Model -> Formula
--evaluate(_,_) = True
