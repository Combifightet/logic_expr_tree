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
  
  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      LogicObj rightMost = objects[i];
      for (LogicObj obj in objects) {
        if (obj.getY()==rightMost.getY() && obj.getX()>rightMost.getX()) {
          rightMost = obj;
        }
      }
      result += 'u$i |->u${objects.indexOf(rightMost)}';
      if (i<objects.length-1) {
        result += ',\n${' '*16}';
      }
    }
    return '$result}\n';
  }
}