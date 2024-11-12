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
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return ((obj[0].getX()-obj[1].getX()).abs()==1 && obj[0].getY()==obj[1].getY()) || ((obj[0].getY()-obj[1].getY()).abs()==1 && obj[0].getX()==obj[1].getX());
  }

  @override
  Type getType() => Type.pAdjoins;
  @override
  Adjoins clone() => Adjoins();
  @override
  String toString() => 'Adjoins';

  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      for (int j=i; j<objects.length; j++) {
        if (((objects[i].getX()-objects[j].getX()).abs()==1 && objects[i].getY()==objects[j].getY()) || ((objects[i].getY()-objects[j].getY()).abs()==1 && objects[i].getX()==objects[j].getX())) {
          result += '${result.length<=16?'':','}(u$i,u$j)';
        }
      }
    }
    return '$result}\n';
  }
}