import '../atomic_expression.dart';
import '../expression_tree.dart';
import '../../fol_world.dart';
import 'predicate.dart';

class Dodec extends Predicate {
  final int _airity = 1;
  Dodec();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) {
    assert(node?.getRight()==null);
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    List tempL = [left.getData()?.getValue(world, variables)];
    List<LogicObj> obj = tempL.expand((i) => i).toList() as List<LogicObj>;
    assert(obj.length==_airity);
    return obj[0].type==ObjectType.Dodec;
  }

  @override
  Type getType() => Type.pDodec;
  @override
  Dodec clone() => Dodec();
  @override
  String toString() => 'Dodec';
}