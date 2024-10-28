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

  void rotateCCW(double x, double y) {
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
  void rotateCW(double x, double y) {
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

  // TODO: implement toPL1
  String toPL1() {
    throw UnimplementedError("need to implement / understand to PL1");
    // ---Universe---
    // Universe |-> {u0,u1}
    // ---Constants---
    // n0    |-> u0
    // n1    |-> u1
    // ---Predicates---
    // Cube       |-> {u0}
    // Dodec      |-> {u1}
    // ---Functions---
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
    return '{"Id":-1,"UniverseKey":"","Consts":[$constsString],"Predicates":["$type","$size"],"Tags":[$_x,$_y]}';
    //      {"Id":-1,"UniverseKey":"","Consts":[],"Predicates":["Cube","Small"],"Tags":[3,3]}
  }
}