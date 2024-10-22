import 'package:logic_expr_tree/logic_expr_tree.dart';


void main() {
  // TODO: add example main
  List<String> testScentences = [
    '⊥∨(x∀Cube(x))',
    'Between(a,b,c)',
    'SameShape(a,b)',
    'Cube(a)',
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

  print('input = \'${testScentences[1]}\'');

  ExpressionParser p = ExpressionParser();
  p.setVerbose(true);
  ExpressionTree tree = p.parse(testScentences[1]);

  print('output = \'$tree\'');
  print(tree.toTikZ());

  print(tree.getValue(world, {}));

}
