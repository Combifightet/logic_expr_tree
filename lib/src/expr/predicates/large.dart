import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class Large extends Predicate {
  final int _airity = 1;
  Large();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].size==ObjectSize.Large;
  }

  @override
  Type getType() => Type.pLarge;
  @override
  Large clone() => Large();
  @override
  String toString() => 'Large';

  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      if (objects[0].size==ObjectSize.Large) {
        result += '${result.length<=16?'':','}u$i';
      }
    }
    return '$result}\n';
  }
}