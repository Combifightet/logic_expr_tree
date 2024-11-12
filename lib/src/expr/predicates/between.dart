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
    List<LogicObj> obj = left.getData()?.getValue(world, variables);
    assert(obj.length==_airity);
    return (obj[0].getY()==obj[1].getY()&&obj[0].getY()==obj[2].getY()&&(obj[0].getX()-obj[1].getX())*(obj[2].getX()-obj[0].getX())>0)
        || (obj[0].getX()==obj[1].getX()&&obj[0].getX()==obj[2].getX()&&(obj[0].getY()-obj[1].getY())*(obj[2].getY()-obj[0].getY())>0)
        || (obj[0].getY()-obj[1].getY()/obj[0].getX()-obj[1].getX()==obj[2].getY()-obj[0].getY()/obj[2].getX()-obj[0].getX()
            && obj[0].getY()-obj[1].getY()==obj[0].getX()-obj[1].getX());       // to only allow 45° diagonals
  }

  @override
  Type getType() => Type.pBetween;
  @override
  Between clone() => Between();
  @override
  String toString() => 'Between';

  @override
  String all(List<LogicObj> objects) {
    String result = '${toString().padRight(10)} |-> {';
    for (int i=0; i<objects.length; i++) {
      for (int j=i; j<objects.length; j++) {
        for (int k=0; k<objects.length; k++) {
          if ((objects[i].getY()==objects[j].getY()&&objects[i].getY()==objects[k].getY()&&(objects[i].getX()-objects[j].getX())*(objects[k].getX()-objects[i].getX())>0)
           || (objects[i].getX()==objects[j].getX()&&objects[i].getX()==objects[k].getX()&&(objects[i].getY()-objects[j].getY())*(objects[k].getY()-objects[i].getY())>0)
           || (objects[i].getY()-objects[j].getY()/objects[i].getX()-objects[j].getX()==objects[k].getY()-objects[i].getY()/objects[k].getX()-objects[i].getX()
               && objects[i].getY()-objects[j].getY()==objects[i].getX()-objects[j].getX())) {       // to only allow 45° diagonals
            result += '${result.length<=16?'':','}(u$i,u$j,u$k)';
          }
        }
      }
    }
    return '$result}\n';
  }
}