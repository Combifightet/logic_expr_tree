import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class Cube extends Predicate {
  final int _airity = 1;
  Cube();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].type==ObjectType.Cube;
  }

  @override
  Type getType() => Type.pCube;
  @override
  Cube clone() => Cube();
  @override
  String toString() => 'Cube';

  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      if (objects[0].type==ObjectType.Cube) {
        result += '${result.length<=16?'':','}u$i';
      }
    }
    return '$result}\n';
  }
}