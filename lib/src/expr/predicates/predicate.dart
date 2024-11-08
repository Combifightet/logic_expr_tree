// import '../../fol_world.dart';
import '../atomic_expression.dart';

import 'tet.dart';          // 1
import 'cube.dart';
import 'dodec.dart';
import 'small.dart';
import 'medium.dart';
import 'large.dart';
import 'same_shape.dart';   // 2
import 'same_size.dart';
import 'front_of.dart';
import 'right_of.dart';
import 'same_col.dart';
import 'same_row.dart';
import 'adjoins.dart';
import 'back_of.dart';
import 'left_of.dart';
import 'smaller.dart';
import 'larger.dart';
import 'between.dart';      // 3

export 'tet.dart';          // 1
export 'cube.dart';
export 'dodec.dart';
export 'small.dart';
export 'medium.dart';
export 'large.dart';
export 'same_shape.dart';   // 2
export 'same_size.dart';
export 'front_of.dart';
export 'right_of.dart';
export 'same_col.dart';
export 'same_row.dart';
export 'adjoins.dart';
export 'back_of.dart';
export 'left_of.dart';
export 'smaller.dart';
export 'larger.dart';
export 'between.dart';      // 3

Map<Type, Predicate> predicates = {
  Type.pTet: Tet(),
  Type.pCube: Cube(),
  Type.pDodec: Dodec(),
  Type.pSmall: Small(),
  Type.pMedium: Medium(),
  Type.pLarge: Large(),
  Type.pSmaller: Smaller(),
  Type.pLarger: Larger(),
  Type.pLeftOf: LeftOf(),
  Type.pRightOf: RightOf(),
  Type.pBackOf: BackOf(),
  Type.pFrontOf: FrontOf(),
  Type.pSameSize: SameSize(),
  Type.pSameShape: SameShape(),
  Type.pSameRow: SameRow(),
  Type.pSameCol: SameCol(),
  Type.pAdjoins: Adjoins(),
  Type.pBetween: Between(),
};

abstract class Predicate extends AtomicExpression {
  // ignore: unused_field
  late final int _airity;
  // TODO: not yet implementted
  // String all(List<LogicObj> objects);
}