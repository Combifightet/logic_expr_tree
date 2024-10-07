import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class Adjoins extends Predicate {
  final int _airity = 2;
  Adjoins();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List tempL = [left.getData()?.getValue(world, variables)];
    List<LogicObj> obj = tempL.expand((i) => i).toList() as List<LogicObj>;
    assert(obj.length==_airity);
    return (obj[0].getX()-obj[1].getX()).abs()==1 || (obj[0].getY()-obj[1].getY()).abs()==1;
  }

  @override
  Type getType() => Type.pAdjoins;
  @override
  Adjoins clone() => Adjoins();
  @override
  String toString() => 'Adjoins';
}