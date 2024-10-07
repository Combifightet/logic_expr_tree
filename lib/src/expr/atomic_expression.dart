import 'expression_tree.dart';
import '../fol_world.dart';

enum Type {
  opConjunction,
  opDisjunction,
  opNegation,
  opEqual,
  opNotEqual,
  opImplication,
  opBiimplication,
  opUniversalQuant,
  opExistentialQuant,
  
  tTautology,
  tContradiction,
  tConstant,
  tVariable,
  
  fRm,
  fLm,
  fFm,
  fBm,
  
  pTet,       // Arity 1
  pCube,
  pDodec,
  pSmall,
  pMedium,
  pLarge,
  pSmaller,   // Arity 2
  pLarger,
  pLeftOf,
  pRightOf,
  pBackOf,
  pFrontOf,
  pSameSize,
  pSameShape,
  pSameRow,
  pSameCol,
  pAdjoins,
  pBetween,   // Arity 3

  uBracketOpen,
  uBracketClose,
  uEndOfInput,
  uComma;

  bool isPredicate() => toString().startsWith('Type.p');
  bool isFunction()  => toString().startsWith('Type.f');
}

abstract class AtomicExpression {
  ExpressionTree? node;

  bool isOperator() => !isTerminal();
  bool isTerminal() => node==null||node!.isLeaf();

  Type getType();
  dynamic getValue(FolWorld world, Map<String, LogicObj> variables);

  AtomicExpression clone() {
    throw Exception('You didn\'t overwrite clone()!');
  }

}