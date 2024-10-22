import 'package:logic_expr_tree/logic_expr_tree.dart';


void main() {
  // TODO: add example main
  List<String> testScentences = [
    'bm(a)',
    // '⊥∨(x∀Cube(x))',
    // 'Between(a,b,c)',
    // 'SameShape(a,b)',
    // 'Cube(a)',
  ];

  FolWorld world = FolWorld();
  world.createObj(
    1,1,
    ObjectType.Cube,
    ObjectSize.Medium,
    ['a']
  );
  world.createObj(
    1,0,
    ObjectType.Cube,
    ObjectSize.Medium,
    ['b']
  );
  world.createObj(
    1,2,
    ObjectType.Cube,
    ObjectSize.Medium,
    ['c']
  );

  for (String input in testScentences) {
    print('------------------------------------------------------------------');
    print('input = \'$input\'');

    ExpressionParser p = ExpressionParser();
    p.setVerbose(true);
    ExpressionTree tree = p.parse(input);

    print('output = \'$tree\'');
    print(tree.toTikZ());

    print(tree.getValue(world, {}));
  }

}
