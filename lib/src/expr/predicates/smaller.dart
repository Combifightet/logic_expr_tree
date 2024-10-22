import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class Smaller extends Predicate {
  final int _airity = 2;
  Smaller();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return obj[0].size<obj[1].size;
  }

  @override
  Type getType() => Type.pSmaller;
  @override
  Smaller clone() => Smaller();
  @override
  String toString() => 'Smaller';
}