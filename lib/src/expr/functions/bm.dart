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
  
  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      LogicObj backMost = objects[i];
      for (LogicObj obj in objects) {
        if (obj.getX()==backMost.getX() && obj.getY()>backMost.getY()) {
          backMost = obj;
        }
      }
      result += 'u$i |->u${objects.indexOf(backMost)}';
      if (i<objects.length-1) {
        result += ',\n${' '*16}';
      }
    }
    return '$result}\n';
  }
}