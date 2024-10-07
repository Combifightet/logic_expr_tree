import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'operator.dart';

class Biimplication extends Operator {
  Biimplication();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    ExpressionTree right =  node?.getRight() as ExpressionTree;
    return (left.getData()?.getValue(world, variables) && right.getData()?.getValue(world, variables)) || (!left.getData()?.getValue(world, variables) && !right.getData()?.getValue(world, variables));
  }

  @override
  Type getType() => Type.opBiimplication;
  @override
  Biimplication clone() => Biimplication();
  @override
  String toString() => '↔';
}