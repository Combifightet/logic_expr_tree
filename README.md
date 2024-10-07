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
    ...
]
```

- [ ] read / write `.sen` _(logic sentence files)_

```txt
["∀x (Dodec(x) → Small(x))","¬∃v Tet(v)"]
```

- [ ] game ???

### Create a fucking expression tree

### Implement PL1 Syntax

#### Predicate symbols

**Arity 1:**

- [xx] Sqr(a)  / Cube(a)                 (**pCube**)
- [xx] Tri(a)  / Tet(a)                  (**pTet**)
- [xx] Pent(a) / Dodec(a)                (**pDodec**)
- [xx] Small(a)                          (**pSmall**)
- [xx] Medium(a)                         (**pMedium**)
- [xx] Large(a)                          (**pLarge**)

**Arity 2:**

- [xx] Smaller(a, b)                     (**pSmaller**)
- [xx] Larger(a, b)                      (**pLarger**)
- [xx] LeftOf(a, b)                      (**pLeftOf**)
- [xx] RightOf(a, b)                     (**pRightOf**)
- [xx] AboveOf(a, b)  / BackOf(a, b)     (**pAboveOf**)
- [xx] BelowOf(a, b)  / FrontOf(a, b)    (**pBelowOf**)
- [xx] SameSize(a, b)                    (**pSameSize**)
- [xx] SameShape(a, b)                   (**pSameShape**)
- [xx] SameRow(a, b)                     (**pSameRow**)
- [xx] SameCol(a, b)                     (**pSameCol**)
- [xx] Adjoins(a, b) _(not diagonal)_    (**pAdjoins**)

**Arity 3:**

- [xx] Between(a, b, c)                  (**pBetween**)

#### Funtion symbols

- [xx] rm(a)                             (**fRm**)
- [xx] lm(a)                             (**fLm**)
- [xx] fm(a)                             (**fFm**)
- [xx] bm(a)                             (**fBm**)

#### Operator symbols

- [xx] ∧     logical conjunction         (**opConjunction**)
- [xx] ∨     logical disjunction         (**opDisjunction**)
- [xx] ¬     negation                    (**opNegation**)
- [xx] =     equal                       (**opEqual**)
- [xx] ≠     not equal                   (**opNotEqual**)
- [xx] →     material implication        (**opImplication**)
- [xx] ↔     material equivalence        (**opBiimplication**)
- [xx] ∀     universal quantification    (**opUniversalQuant**)
- [xx] ∃     existential quantification  (**opExistentialQuant**)

#### Constant symbols

- [xx] ⊤     tautology                   (**tTautology**)
- [xx] ⊥     contradiction               (**tContradiction**)
- [xx] a-f   constants                   (**tConstant**)
- [xx] u-z   variables                   (**tVariable**)

#### Utility symbols (internal use only)

- [xx] (                                 (**uuBracketOpen**)
- [xx] )                                 (**uuBracketClose**)
