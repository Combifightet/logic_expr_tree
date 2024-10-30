import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class SameRow extends Predicate {
  final int _airity = 2;
  SameRow();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].getY()==obj[1].getY();
  }

  @override
  Type getType() => Type.pSameRow;
  @override
  SameRow clone() => SameRow();
  @override
  String toString() => 'SameRow';
}