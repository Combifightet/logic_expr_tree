import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'functions.dart';

class Bm extends Functions {
  Bm();

  @override 
  List<LogicObj> getValue(FolWorld world, Map<String, LogicObj> variables) {
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    assert(node?.getRight()==null); // unary operation
    LogicObj backMost = left.getData()?.getValue(world, variables)[0];
    for (LogicObj obj in world.getWorld()) {
      if (obj.getX()==backMost.getX() && obj.getY()>backMost.getY()) {
        backMost = obj;
      }
    }
    return [backMost];
  }

  @override
  Type getType() => Type.fBm;
  @override
  Bm clone() => Bm();
  @override
  String toString() => 'bm';
}