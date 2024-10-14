# Logic Expression Tree

## World

```cmd
x →
 0,1 | 1,1 
-----+----- ↑
 0,0 | 1,0  y

```

## TODOs

- [ ] read / write `.wld` _(world data files)_

```json
[
    {
        "Consts": ["a"],
        "Predicates": [
            "Cube",
            "Large"
        ],
        "Tags": [1,2]
    },
    "..."
]
```

- [ ] read / write `.sen` _(logic sentence files)_

```t
["∀x (Dodec(x) → Small(x))","¬∃v Tet(v)"]
```

- [ ] game ???

### Create a fucking expression tree

### Implement PL1 Syntax

#### Predicate symbols

**Arity 1:**

- [x] Sqr(a)  / Cube(a)                 (**pCube**)
- [x] Tri(a)  / Tet(a)                  (**pTet**)
- [x] Pent(a) / Dodec(a)                (**pDodec**)
- [x] Small(a)                          (**pSmall**)
- [x] Medium(a)                         (**pMedium**)
- [x] Large(a)                          (**pLarge**)

**Arity 2:**

- [x] Smaller(a, b)                     (**pSmaller**)
- [x] Larger(a, b)                      (**pLarger**)
- [x] LeftOf(a, b)                      (**pLeftOf**)
- [x] RightOf(a, b)                     (**pRightOf**)
- [x] AboveOf(a, b)  / BackOf(a, b)     (**pAboveOf**)
- [x] BelowOf(a, b)  / FrontOf(a, b)    (**pBelowOf**)
- [x] SameSize(a, b)                    (**pSameSize**)
- [x] SameShape(a, b)                   (**pSameShape**)
- [x] SameRow(a, b)                     (**pSameRow**)
- [x] SameCol(a, b)                     (**pSameCol**)
- [x] Adjoins(a, b) _(not diagonal)_    (**pAdjoins**)

**Arity 3:**

- [x] Between(a, b, c)                  (**pBetween**)

#### Funtion symbols

- [x] rm(a)                             (**fRm**)
- [x] lm(a)                             (**fLm**)
- [x] fm(a)                             (**fFm**)
- [x] bm(a)                             (**fBm**)

#### Operator symbols

- [x] ∧     logical conjunction         (**opConjunction**)
- [x] ∨     logical disjunction         (**opDisjunction**)
- [x] ¬     negation                    (**opNegation**)
- [x] =     equal                       (**opEqual**)
- [x] ≠     not equal                   (**opNotEqual**)
- [x] →     material implication        (**opImplication**)
- [x] ↔     material equivalence        (**opBiimplication**)
- [x] ∀     universal quantification    (**opUniversalQuant**)
- [x] ∃     existential quantification  (**opExistentialQuant**)

#### Constant symbols

- [x] ⊤     tautology                   (**tTautology**)
- [x] ⊥     contradiction               (**tContradiction**)
- [x] a-f   constants                   (**tConstant**)
- [x] u-z   variables                   (**tVariable**)

#### Utility symbols (internal use only)

- [x] (                                 (**uuBracketOpen**)
- [x] )                                 (**uuBracketClose**)
