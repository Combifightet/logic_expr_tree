import 'atomic_expression.dart';
import 'expression_tree.dart';
import '../fol_world.dart';

abstract class Utility extends AtomicExpression {} 

class Comma extends Utility {

  Comma();


  @override 
  List<LogicObj> getValue(FolWorld world, Map<String, LogicObj> variables) {
    ExpressionTree left =  node?.getLeft() as ExpressionTree;
    ExpressionTree right =  node?.getRight() as ExpressionTree;
    List tempL = [left.getData()?.getValue(world, variables), right.getData()?.getValue(world, variables)];
    return tempL.expand((i) => i).toList() as List<LogicObj>;
  }

  @override
  Type getType() => Type.uComma;
  @override
  Comma clone() => Comma();
  @override
  String toString() => ',';
  }
  
