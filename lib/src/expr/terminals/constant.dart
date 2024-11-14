import '../atomic_expression.dart';
import '../../fol_world.dart';
import 'terminal.dart';

class Constant extends Terminal {
  late final String _name;

  Constant(this._name) {assert(_name.length==1);}

  String getName() => _name;

  @override 
  List<LogicObj> getValue(FolWorld world, Map<String, LogicObj> variables) {
    return [world.getWorld().firstWhere((obj) => obj.hasConst(_name), orElse:() => throw UnsupportedError('cannot find constant: \'$_name\''))];
  }

  @override
  Type getType() => Type.tConstant;
  @override
  Constant clone() => Constant(_name);
  @override
  String toString() => _name;
}