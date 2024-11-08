import '../../fol_world.dart';
import '../atomic_expression.dart';

import 'lm.dart';
import 'rm.dart';
import 'bm.dart';
import 'fm.dart';

export 'lm.dart';
export 'rm.dart';
export 'bm.dart';
export 'fm.dart';

Map<Type, Functions> functions = {
  Type.fLm: Lm(),
  Type.fRm: Rm(),
  Type.fBm: Bm(),
  Type.fFm: Fm(),
};

abstract class Functions extends AtomicExpression {
  String all(List<LogicObj> objects);
}
