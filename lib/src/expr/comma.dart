import 'atomic_expression.dart';
import 'expression_tree.dart';
import '../fol_world.dart';

abstract class Utility extends AtomicExpression {} 

class Comma extends Utility {

  Comma();

  List<LogicObj> _flatten(List<dynamic> list) {
    List<LogicObj> resultList = [];
    for (var l in list) {
      if (l.runtimeType==List<LogicObj>) {
        resultList.addAll(l);
      } else if (l.runtimeType==List<dynamic>) {
        resultList.addAll(_flatten(l));
      } else {
        resultList.add(l);
      }
    }
    return resultList;
  }


  @override 
  List<LogicObj> getValue(FolWorld world, Map<String, LogicObj> variables) {
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    ExpressionTree right =  node?.getRight() as ExpressionTree;
    List tempL = [left.getData()?.getValue(world, variables), right.getData()?.getValue(world, variables)];
    return _flatten(tempL);
  }

  @override
  Type getType() => Type.uComma;
  @override
  Comma clone() => Comma();
  @override
  String toString() => ',';
  }
  
