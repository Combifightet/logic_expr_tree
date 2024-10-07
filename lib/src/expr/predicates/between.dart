import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class Between extends Predicate {
  final int _airity = 3;
  Between();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List tempL = [left.getData()?.getValue(world, variables)];
    List<LogicObj> obj = tempL.expand((i) => i).toList() as List<LogicObj>;
    assert(obj.length==_airity);
    return (obj[0].getY()==obj[1].getY()&&obj[0].getY()==obj[2].getY()&&(obj[0].getX()-obj[1].getX())*(obj[2].getX()-obj[0].getX())>0)
        || (obj[0].getX()==obj[1].getX()&&obj[0].getX()==obj[2].getX()&&(obj[0].getY()-obj[1].getY())*(obj[2].getY()-obj[0].getY())>0);
  }

  @override
  Type getType() => Type.pBetween;
  @override
  Between clone() => Between();
  @override
  String toString() => 'Between';
}