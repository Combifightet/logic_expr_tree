import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class FrontOf extends Predicate {
  final int _airity = 2;
  FrontOf();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].getY()>obj[1].getY();
  }

  @override
  Type getType() => Type.pFrontOf;
  @override
  FrontOf clone() => FrontOf();
  @override
  String toString() => 'FrontOf';
}