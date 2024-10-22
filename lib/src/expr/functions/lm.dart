import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'functions.dart';

class Lm extends Functions {
  Lm();

  @override 
  List<LogicObj> getValue(FolWorld world, Map<String, LogicObj> variables) {
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    assert(node?.getRight()==null); // unary operation
    LogicObj leftMost = left.getData()?.getValue(world, variables)[0];
    for (LogicObj obj in world.getWorld()) {
      if (obj.getY()==leftMost.getY() && obj.getX()<leftMost.getX()) {
        leftMost = obj;
      }
    }
    return [leftMost];
  }

  @override
  Type getType() => Type.fLm;
  @override
  Lm clone() => Lm();
  @override
  String toString() => 'lm';
}