import 'package:logic_expr_tree/logic_expr_tree.dart';


void main() {
  // TODO: add example main
  List<String> testScentences = [
    '⊥∨(x∀Cube(x))',
  ];

  ExpressionParser p = ExpressionParser();

  p.main();


}
