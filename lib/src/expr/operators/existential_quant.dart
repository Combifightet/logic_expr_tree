import '../terminals/variable.dart';
import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'operator.dart';

class ExistentialQuant extends Operator {
  ExistentialQuant();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getLeft()?.getData()?.getType()==Type.tVariable);
    Variable left =  node?.getLeft()?.getData() as Variable;
    ExpressionTree right =  node?.getRight() as ExpressionTree;
    for (LogicObj obj in world.getWorld()) {
      variables[left.getName()] = obj;
      if (right.getData()?.getValue(world, variables)) {
        variables.remove(left.getName());
        return true;
      }
    }
    variables.remove(left.getName());
    return false;
  }

  @override
  Type getType() => Type.opExistentialQuant;
  @override
  ExistentialQuant clone() => ExistentialQuant();
  @override
  String toString() => '∃';
}