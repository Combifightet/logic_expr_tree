import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'functions.dart';

class Fm extends Functions {
  Fm();

  @override 
  List<LogicObj> getValue(FolWorld world, Map<String, LogicObj> variables) {
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    assert(node?.getRight()==null); // unary operation
    LogicObj frontMost = left.getData()?.getValue(world, variables)[0];
    for (LogicObj obj in world.getWorld()) {
      if (obj.getX()==frontMost.getX() && obj.getY()<frontMost.getY()) {
        frontMost = obj;
      }
    }
    return [frontMost];
  }

  @override
  Type getType() => Type.fFm;
  @override
  Fm clone() => Fm();
  @override
  String toString() => 'fm';
  
  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      LogicObj frontMost = objects[i];
      for (LogicObj obj in objects) {
        if (obj.getX()==frontMost.getX() && obj.getY()<frontMost.getY()) {
          frontMost = obj;
        }
      }
      result += 'u$i |->u${objects.indexOf(frontMost)}';
      if (i<objects.length-1) {
        result += ',\n${' '*16}';
      }
    }
    return '$result}\n';
  }
}