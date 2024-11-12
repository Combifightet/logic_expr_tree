import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class Medium extends Predicate {
  final int _airity = 1;
  Medium();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].size==ObjectSize.Medium;
  }

  @override
  Type getType() => Type.pMedium;
  @override
  Medium clone() => Medium();
  @override
  String toString() => 'Medium';

  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      if (objects[i].size==ObjectSize.Medium) {
        result += '${result.length<=16?'':','}u$i';
      }
    }
    return '$result}\n';
  }
}