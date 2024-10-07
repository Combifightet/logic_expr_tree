import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'functions.dart';

class Rm extends Functions {
  Rm();

  @override 
  LogicObj getValue(FolWorld world, Map<String, LogicObj> variables) {
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    assert(node?.getRight()==null); // unary operation
    LogicObj rightMost = left.getData()?.getValue(world, variables);
    for (LogicObj obj in world.getWorld()) {
      if (obj.getY()==rightMost.getY() && obj.getX()>rightMost.getX()) {
        rightMost = obj;
      }
    }
    return rightMost;
  }

  @override
  Type getType() => Type.fRm;
  @override
  Rm clone() => Rm();
  @override
  String toString() => 'rm';
}