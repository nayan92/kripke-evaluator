Kripke Evaluator
================

A tool for evaluating satisfaction of Kripke Models.

GHCi is required to use the tool. Setup is as follows:
  ghci evaluate.hs

To check that a satisfaction of the form:

    (M, w) |= f
is valid, you run the function 'evaluate' in the following fashion:

    evaluate M w f

- M is the Model (using abusive notation as explained in lecture notes)
and so contains 3 parameters:
  - World W : This is the world in the model, and contains a set/list of nodes (eg. [w1, w2...])
  - Relation R : This is the relation between nodes in the world (subset of (W x W)). It is a list of tuples of the form [(w1, w2), (w2, w3)...]
  - Valuation pi : This is the valuation for the atoms. It is a list of tuples of the form [(p, w1), (p, w2), (q, w2)...]
- w is a node in the world W
- f is a formula defined using the following Haskell data structure:

    type Atom = String  
    
    data Formula = Var Atom | TrueT | FalseT | Not Formula | And Formula Formula | Box Formula | Diamond Formula | Implies Formula Formula

Here are some examples to get you started:

    > evaluate (["w1", "w2"], [("w1", "w2")], [("p", "w1")]) "w1" (Var "p")
    > True

    > evaluate (["w1", "w2"], [("w1", "w2")], [("p", "w1")]) "w2" (Var "p")
    > False

    > evaluate (["w1", "w2", "w3", "w4"], [("w2", "w1"), ("w3","w2"), ("w4","w2"), ("w4","w3"), ("w3","w3")], [("p", "w2"), ("p","w4"), ("q","w2"), ("q","w3"), ("q","w4")]) "w4" (Diamond (Var "p"))
    > True
