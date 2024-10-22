import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class BackOf extends Predicate {
  final int _airity = 2;
  BackOf();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].getY()<obj[1].getY();
  }

  @override
  Type getType() => Type.pBackOf;
  @override
  BackOf clone() => BackOf();
  @override
  String toString() => 'BackOf';
}