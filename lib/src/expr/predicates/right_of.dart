import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class RightOf extends Predicate {
  final int _airity = 2;
  RightOf();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].getX()>obj[1].getX();
  }

  @override
  Type getType() => Type.pRightOf;
  @override
  RightOf clone() => RightOf();
  @override
  String toString() => 'RightOf';

  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      for (int j=0; j<objects.length; j++) {
        if (objects[i].getX()>objects[j].getX()) {
          result += '${result.length<=16?'':','}(u$i,u$j)';
        }
      }
    }
    return '$result}\n';
  }
}