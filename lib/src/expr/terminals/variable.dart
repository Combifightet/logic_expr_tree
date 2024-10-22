import '../atomic_expression.dart';
import '../../fol_world.dart';
import 'terminal.dart';

class Variable extends Terminal {
  late final String _name;

  Variable(this._name) {assert(_name.length==1);}

  String getName() => _name;

  @override 
  List<LogicObj> getValue(FolWorld world, Map<String, LogicObj> variables) {
    if (variables.keys.contains(_name)) {
      return [variables[_name] as LogicObj];
    }
    throw UnsupportedError('don\'t know value of variable: \'$_name\'');
  }

  @override
  Type getType() => Type.tVariable;
  @override
  Variable clone() => Variable(_name);
  @override
  String toString() => _name;
  }
  
