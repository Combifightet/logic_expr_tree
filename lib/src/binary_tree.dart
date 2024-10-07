import 'binary_tree_traversal.dart';


class BinaryTree<T> {
  BinaryTree? _parent;
  BinaryTree? _left;
  BinaryTree? _right;
  T?          _data;

  BinaryTree(T data, [BinaryTree<T>? left, BinaryTree<T>? right]) {
    _data=data;
    _left=left; 
    _right=right;
    _left?._parent=this;
    _right?._parent=this;
  }

  BinaryTree<T>? setLeft(BinaryTree<T>? tree) {
    BinaryTree<T>? oldLeft = _left as BinaryTree<T>?;
    _left?._parent = null;
    _left = tree;
    _left?._parent = this;
    return oldLeft;
  }

  BinaryTree<T>? setRight(BinaryTree<T>? tree) {
    BinaryTree<T>? oldRight = _right as BinaryTree<T>?;
    _right?._parent = null;
    _right = tree;
    _right?._parent = this;
    return oldRight;
  }

  void setData(T data) => _data = data;
  T? getData() => _data;

  BinaryTree<T>? getParent() => _parent as BinaryTree<T>?;
  BinaryTree<T>? getLeft() => _left as BinaryTree<T>?;
  BinaryTree<T>? getRight() => _right as BinaryTree<T>?;

  bool isRoot() => getParent()==null;
  bool isLeaf() => getLeft()==null && getRight()==null;

  BinaryTree<T> getRoot() {
    BinaryTree<T> node = this;
    while (!node.isRoot()) {
      node = node._parent as BinaryTree<T>;
    }
    return node;
  }


  BinaryTreeTraversal<T> preorder() {
    return BinaryTreeTraversal<T>.preorder(this);
  }
  BinaryTreeTraversal<T> inorder() {
    return BinaryTreeTraversal<T>.inorder(this);
  }
  BinaryTreeTraversal<T> postorder() {
    return BinaryTreeTraversal<T>.postorder(this);
  }
  BinaryTreeTraversal<T> levelorder() {
    return BinaryTreeTraversal<T>.levelorder(this);
  }


  @override
  String toString() {
    return getData()!=null ? getData().toString() : 'null';
  }

  // get String representation for commandline output 
  String toText() {
    return toTextHelper(0);
  }
  String toTextHelper(int level) {
    String text='';
    text+='${'  '*(level)}+- ${textLabel()}\n';

    if (getLeft()==null && getRight()==null) {
      return text;
    }

    if (getLeft()!=null) {
      text+=getLeft()!.toTextHelper(level+1);
    } else {
      text+='${'  '*(level+1)}+-\n';
    }

    if (getRight()!=null) {
      text+=getRight()!.toTextHelper(level+1);
    } else {
      text += '${'  '*(level+1)}+-\n';
    }
    return text;
  }
  String textLabel() => getData().toString();

  // get TikZ code for LaTeX export
  String toTikZ() {
    return '\\${toTikZHelper(0)};\n';
  }
  String tikzNodeStyle() { return ''; }
  String toTikZHelper(int level) {
    String spaces = '  ' * level;
    String tex = '${spaces}node ${tikzNodeStyle()} {${getData()}}\n';
    if (getLeft()!=null) {
      tex += '$spaces child[left] {\n${getLeft()!.toTikZHelper(level+1)}$spaces }\n';
    }
    if (getRight()!=null) {
      tex += '$spaces child[right] {\n${getRight()!.toTikZHelper(level+1)}$spaces }\n';
    }

    return tex;
  }



  void main() {
    BinaryTree<String> a = BinaryTree<String>('A');
    BinaryTree<String> b = BinaryTree<String>('B');
    BinaryTree<String> c = BinaryTree<String>('C');
    BinaryTree<String> d = BinaryTree<String>('D');

    a.setLeft(b);
    a.setRight(c);
    c.setLeft(d);

    print(a);
    print(a.toText());
    print(a.toTikZ());

    print('preorder:    ${a.preorder()}');
    print('inorder:     ${a.inorder()}');
    print('postorder:   ${a.postorder()}');
    print('level-order: ${a.levelorder()}');
  }
}