import 'terminal.dart';
import '../atomic_expression.dart';
import '../../fol_world.dart';

class Contradiction extends Terminal {
  Contradiction();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) => false;

  @override
  Type getType() => Type.tContradiction;
  @override
  Contradiction clone() => Contradiction();
  @override
  String toString() => '⊥';
}