import '../atomic_expression.dart';

export 'conjunction.dart';
export 'disjunction.dart';
export 'negation.dart';
export 'equal.dart';
export 'not_equal.dart';
export 'implication.dart';
export 'biimplication.dart';
export 'universal_quant.dart';
export 'existential_quant.dart';

abstract class Operator extends AtomicExpression {}
