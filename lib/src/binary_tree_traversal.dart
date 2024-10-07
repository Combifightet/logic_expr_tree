import 'dart:collection';

import 'binary_tree.dart';

class BinaryTreeTraversal<T> {
  // ignore: prefer_final_fields
  List<T> _data = [];

  BinaryTreeTraversal.preorder(BinaryTree<T> tree) {
    _preorderTraversal(tree);
  }
  BinaryTreeTraversal.inorder(BinaryTree<T> tree) {
    _inorderTraversal(tree);
  }
  BinaryTreeTraversal.postorder(BinaryTree<T> tree) {
    _postorderTraversal(tree);
  }
  BinaryTreeTraversal.levelorder(BinaryTree<T> tree) {
    _levelorderTraversal(tree);
  }

  void _preorderTraversal(BinaryTree<T>? tree) {
    if (tree != null) {
      _data.add(tree.getData() as T);
      _preorderTraversal(tree.getLeft());
      _preorderTraversal(tree.getRight());
    }
  }
  void _inorderTraversal(BinaryTree<T>? tree) {
    if (tree != null) {
      _inorderTraversal(tree.getLeft());
      _data.add(tree.getData() as T);
      _inorderTraversal(tree.getRight());
    }
  }
  void _postorderTraversal(BinaryTree<T>? tree) {
    if (tree != null) {
      _postorderTraversal(tree.getLeft());
      _postorderTraversal(tree.getRight());
      _data.add(tree.getData() as T);
    }
  }
  void _levelorderTraversal(BinaryTree<T>? tree) {
    if (tree==null) {return;}

    Queue<BinaryTree<T>> queue = Queue<BinaryTree<T>>();
    queue.add(tree);

    while (queue.isNotEmpty) {
      BinaryTree<T> node = queue.removeFirst();
      _data.add(node.getData() as T);

      if (node.getLeft()!=null) {
        queue.add(node.getLeft() as BinaryTree<T>);
      }
      if (node.getRight()!=null) {
        queue.add(node.getRight() as BinaryTree<T>);
      }
    }
  }

  @override
  String toString() {
    String res = '';
    for (var i = 0; i < _data.length; i++) {
      res+=_data[i].toString();
      if (i<_data.length-1) {res+=', ';}
    }
    return res;
  }
}




