import '../atomic_expression.dart';
import '../../fol_world.dart';
import 'terminal.dart';

class Tautology extends Terminal {
  Tautology();

  @override 
  bool getValue(FolWorld world, Map<String, LogicObj> variables) => true;

  @override
  Type getType() => Type.tTautology;
  @override
  Tautology clone() => Tautology();
  @override
  String toString() => '⊤';
}