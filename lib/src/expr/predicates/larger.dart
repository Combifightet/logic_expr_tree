import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class Larger extends Predicate {
  final int _airity = 2;
  Larger();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].size>obj[1].size;
  }

  @override
  Type getType() => Type.pLarger;
  @override
  Larger clone() => Larger();
  @override
  String toString() => 'Larger';

  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      for (int j=0; j<objects.length; j++) {
        if (objects[i].size>objects[j].size) {
          result += '${result.length<=16?'':','}(u$i,u$j)';
        }
      }
    }
    return '$result}\n';
  }
}