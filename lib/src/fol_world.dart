import 'package:logic_expr_tree/logic_expr_tree.dart';

class FolWorld {
  List<LogicObj> _objects = [];

  void clear([int? x, int? y]) {
    assert((x==null&&y==null) || x!=null&&y!=null);
    if (x==null) {
      _objects = [];
    } else {
      _objects.removeWhere((obj) => obj._x==x&&obj._y==y);
    }
  }

  List<LogicObj> getWorld() => _objects;
  
  List<String> getConsts()  {
    List<String> consts = [];
    for (LogicObj obj in _objects) {
      consts.addAll(obj._consts);
    }
    return consts;
  }

  void rotateCW(double x, double y) {
    assert((2*x).floorToDouble()%2==(2*y).floorToDouble()%2);
    x = (2*x).floorToDouble()/2;
    y = (2*y).floorToDouble()/2;
    // to make sure x & y are both either .0 or .5
    for (var obj in _objects) {
      int newX = (obj._y-y+x).floor();
      obj._y=(-obj._x+x+y).floor();
      obj._x=newX;
    }
  }
  void rotateCCW(double x, double y) {
    assert((2*x).floorToDouble()%2==(2*y).floorToDouble()%2);
    x = (2*x).floorToDouble()/2;
    y = (2*y).floorToDouble()/2;
    // to make sure x & y are both either .0 or .5
    for (var obj in _objects) {
      int newX = (-obj._y+y+x).floor();
      obj._y = (obj._x-x+y).floor();
      obj._x=newX;
    }
  }

  bool move(int startX, int startY, int endX, int endY) {
    if (_objects.any((obj) => obj._x==endX&&obj._y==endY) || !_objects.any((obj) => obj._x==startX&&obj._y==startY)) {
      return false;
    }
    _objects.firstWhere((obj) => obj._x==startX&&obj._y==startY).setPos(endX, endY);
    return true;
  }

  bool createObj(int x, int y, ObjectType type, ObjectSize size, [List<String> constants=const[]]) {
    if (_objects.any((obj) => obj._x==x&&obj._y==y)) {
      return false;
    }
    LogicObj obj = LogicObj(x, y, type, size);
    obj.addAllConst(constants);
    _objects.add(obj);
    return true;
  }

  @override
  String toString() {
    String result = '';
    for (int i=0; i<_objects.length; i++) {
      result += _objects[i].toString();
      if (i<_objects.length-1) result+=',';
    }
    return '[$result]';
  }

  final Map<AtomicExpression, RegExp> functionPatterns = {
    Bm(): RegExp(r'bm\('),
    Fm(): RegExp(r'fm\('),
    Lm(): RegExp(r'lm\('),
    Rm(): RegExp(r'rm\('),
  };
  final Map<AtomicExpression, RegExp> predicatePatterns = {
    Adjoins(): RegExp(r'Adjoins\('),
    BackOf(): RegExp(r'BackOf\('),
    Between(): RegExp(r'Between\('),
    Cube(): RegExp(r'Cube\('),
    Dodec(): RegExp(r'Dodec\('),
    FrontOf(): RegExp(r'FrontOf\('),
    Large(): RegExp(r'Large\('),
    Larger(): RegExp(r'Larger\('),
    LeftOf(): RegExp(r'LeftOf\('),
    Medium(): RegExp(r'Medium\('),
    RightOf(): RegExp(r'RightOf\('),
    Small(): RegExp(r'Small\('),
    Smaller(): RegExp(r'Smaller\('),
    SameCol(): RegExp(r'SameCol\('),
    SameRow(): RegExp(r'SameRow\('),
    SameShape(): RegExp(r'SameShape\('),
    SameSize(): RegExp(r'SameSize\('),
    Tet(): RegExp(r'Tet\('),
  };

  // TODO: implement toPL1
  String toPL1(List<String> sentences) {
    String sentence = '';
    if (sentences.isNotEmpty) {
      sentence = sentences[0];
    }
    for (int i=1; i<sentences.length; i++) {
      sentence += '#${sentences[i]}';
    }
    sentence = sentence.replaceAll(' ', '');
    // throw UnimplementedError("need to implement");
    // ---Universe---
    // Universe |-> {u0,u1,u2}            // sorted numerically same as in objects list inside FolWorld (based on creation order)
    // ---Constants---
    // a     |-> u2                       // sorted alphabetically
    // b     |-> u0
    // ---Predicates---
    // Tet        |-> {u0}                // sorted alphabetically
    // Cube       |-> {u1,u2}
    // ---Functions---
    // fm         |-> {u0 |->u0,          // sorted alphabetically
    //                 u1 |->u1,
    //                 u2 |->u1}
    String result = '---Universe---\nUniverse |-> {';
    for (int i=0; i<_objects.length; i++) {
      result+='u$i${i<_objects.length-1?',':''}';
    }
    result += '}\n---Constants---\n';
    List<String> consts = [];
    for (int i=0; i<_objects.length; i++) {
      for (String chr in _objects[i].getConsts()) {
        consts.add('${chr.padRight(6)}|-> u$i');
      }
    }
    consts.sort();
    for (String str in consts) {
      result += '$str\n';
    }
    result += '---Predicates---\n';
    // TODO: implement
    result += '---Functions---\n';
    // TODO: implement
    for (RegExp pattern in functionPatterns.values) {
      if (sentence.contains(pattern)) {
        Functions func = functionPatterns.keys.firstWhere((p) => functionPatterns[p]==pattern) as Functions;
        result += func.all(_objects);
      }
    }
    return result;
  }
}

// ignore: constant_identifier_names
enum ObjectType {Tet, Cube, Dodec;
  int sides() => index+3;
  // bool operator >(other) => index > other.index; 
  // bool operator <(other) => index < other.index;
  // bool operator >=(other) => index >= other.index;
  // bool operator <=(other) => index <= other.index;
}
// ignore: constant_identifier_names
enum ObjectSize {Small, Medium, Large;
  bool operator >(other) => index > other.index; 
  bool operator <(other) => index < other.index;
  // bool operator >=(other) => index >= other.index;
  // bool operator <=(other) => index <= other.index;
}

class LogicObj {
  int _x;
  int _y;
  ObjectType type;
  ObjectSize size;
  List<String> _consts = [];

  LogicObj(this._x, this._y, this.type, this.size);

  int getX() => _x;
  int getY() => _y;
  List<String> getConsts() => _consts;

  void addConst(String constant) {
    _consts.add(constant);
    _consts = _consts.toSet().toList();
  }
  void addAllConst(List<String> constants) {
    for (String con in constants) {
      addConst(con);
    }
  }

  void removeConst(String constant) {
    _consts.remove(constant);
  }

  bool hasConst(String c) => _consts.contains(c);

  void setPos(int x, int y) {_x=x; _y=y;}

  @override
  String toString() {
    String constsString = '';
    for (int i=0; i<_consts.length; i++) {
      constsString += '"${_consts[i]}"';
      if (i<_consts.length-1) constsString+=',';
    }
    // TODO: what the hell are Id and UniverseKey
    return '{"Id":-1,"UniverseKey":"","Consts":[$constsString],"Predicates":["${type.toString().split('.').last}","${size.toString().split('.').last}"],"Tags":[$_x,$_y]}';
  }
}