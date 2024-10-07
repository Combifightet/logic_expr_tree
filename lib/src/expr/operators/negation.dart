import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'operator.dart';

class Negation extends Operator {
  Negation();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    assert(node?.getRight()==null); // unary operation
    return !left.getData()?.getValue(world, variables);
  }

  @override
  Type getType() => Type.opNegation;
  @override
  Negation clone() => Negation();
  @override
  String toString() => '¬';
  }
  
