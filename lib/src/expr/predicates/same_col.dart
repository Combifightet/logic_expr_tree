import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class SameCol extends Predicate {
  final int _airity = 2;
  SameCol();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].getX()==obj[1].getX();
  }

  @override
  Type getType() => Type.pSameCol;
  @override
  SameCol clone() => SameCol();
  @override
  String toString() => 'SameCol';
}