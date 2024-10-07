import '../atomic_expression.dart';

export 'contradiction.dart';
export 'tautology.dart';
export 'constant.dart';
export 'variable.dart';

abstract class Terminal extends AtomicExpression {}
