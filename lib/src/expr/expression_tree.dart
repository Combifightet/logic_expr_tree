import 'atomic_expression.dart';
import '../binary_tree.dart';
import '../fol_world.dart';
import 'functions/functions.dart';
import 'operators/operator.dart';
import 'predicates/predicate.dart';
import 'terminals/terminal.dart';

class ExpressionTree extends BinaryTree<AtomicExpression> {

  ExpressionTree(AtomicExpression atom, [BinaryTree<AtomicExpression>? left, BinaryTree<AtomicExpression>? right]) : super(atom,left,right) {
    if (atom.node!=null) {
      throw Exception('ExpressionTree: AtomicExpression is already bound to another node!');
    }
    atom.node=this;
  }

  dynamic getValue(FolWorld world, Map<String, LogicObj> variables) => getData()?.getValue(world, variables);

  @override
  void setData(AtomicExpression data) {
    if (data.node!=null) {
      throw Exception('ExpressionTree#setData: AtomicExpression is already bound to an ExpressionTree node!');
    }
    super.setData(data);
    data.node=this;
  }

  @override
  String toString() {
    // handle (no) bracket placement for comma
    if (getData()!=null && getData()!.getType()==Type.uComma) {
      return '${getLeft()}${getData()}${getRight()}';
    }

    // handle bracket placement for quantors
    if (getData()!=null && (getData()!.getType()==Type.opUniversalQuant || getData()!.getType()==Type.opExistentialQuant)) {
      return '(${getData()}${getLeft()}(${getRight()}))';
    }

    // handle bracket placement for predicates / functions
    if (getData()!=null && (getData()! is Predicate || getData()! is Functions)) {
      String result = '${getData()}(';
      result += getLeft().toString();
      if (getRight()!=null) {
        result += ',${getRight().toString()}';
      }
      return '$result)';
    }

    // handle terminals
    if (getData()!=null && (getData()!.isTerminal() || getData() is Terminal)) {
      String result = "";
      if (getLeft()!=null) {
        result += '${getLeft().toString()},';
      }
      result += getData().toString();
      if (getRight()!=null) {
        result += ',${getRight().toString()}';
      }
      return result;
    }

    assert(!isLeaf());
    assert(getData()!=null && (getData()!.isOperator() || getData() is Operator));
    // handle other operators
    String result = (!isRoot() ? "(" : "");
    if (getRight()!=null) {
      result += getLeft().toString() + getData().toString() + getRight().toString();
    } else {
      result += getData().toString() + getLeft().toString(); // unary operator
    }
    if (!isRoot()) result += ")";

    return result;
  }


  @override
  void main() {
    ExpressionTree t = 
      ExpressionTree( Disjunction(),
        ExpressionTree( Contradiction()),
        ExpressionTree( UniversalQuant(),
          ExpressionTree( Variable('x')),
          ExpressionTree( Cube(),
            ExpressionTree( Variable('x'))
          )
        )
      );

    FolWorld world = FolWorld();
    world.createObj(3,3,ObjectType.Cube,ObjectSize.Medium, ['a','b','c']);
    world.createObj(3,1,ObjectType.Cube,ObjectSize.Medium);

    print(t);
    print(t.getValue(world, {}));
    print(t.postorder().toString());

    t = ExpressionTree(Conjunction(),
      t, ExpressionTree(Variable('x')));
    print(t);
    // print(t.getValue(world, {})); // throws
  }
}