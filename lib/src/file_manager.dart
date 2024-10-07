import 'dart:convert';
import 'dart:io';

import 'fol_world.dart';

class FileManager {
  String _dir = 'assets/';

  FileManager(this._dir) {
    _dir = _fixDir(_dir);
  }

  String _fixDir(String? dir) {
    if (dir==null) {
      dir=_dir;
    } else {
      dir = dir.replaceAll('\\', '/');
      if (!dir.endsWith('/')) {
        dir += '/';
      }
    }
    return dir;
  }

  // TODO: check implementation
  Map<String, ObjectType> objType = {
    'Tet': ObjectType.Tet,
    'Cube': ObjectType.Cube,
    'Dodec': ObjectType.Dodec,
  };
  Map<String, ObjectSize> objSize = {
    'Small': ObjectSize.Small,
    'Medium': ObjectSize.Medium,
    'Large': ObjectSize.Large,
  };
  Future<FolWorld> readWorld(String name, [String? dir]) async {
    dir = _fixDir(dir);
    name += name.endsWith('.wld')?'':'.wld';
    final File file = File(dir+name);
    FolWorld wld = FolWorld();
    await file.readAsString().then((data) {
      var jsonData = json.decode(data);
      for (var obj in jsonData) {
        List<String> consts = [];
        for (String c in obj['Consts']) {
          consts.add(c);
        }
        wld.createObj(
          obj['Tags'][0],
          obj['Tags'][1],
          objType.entries.firstWhere((e)=>e.key==obj['Predicate'][0]).value,
          objSize.entries.firstWhere((e)=>e.key==obj['Predicate'][1]).value,
          consts
        );
      }
    });
    return wld; 
  }
  void writeWorld(FolWorld wld, [String? name, String? dir]) async {
    name = name ?? '${DateTime.now()}.wld';
    name += name.endsWith('.wld')?'':'.wld';
    dir = _fixDir(dir);
    final File file = File(dir+name);
    await file.writeAsString(wld.toString());
  }

  // TODO: implement readScentence
  List<String> readScentence(String name, [String? dir]) {
    throw UnimplementedError();
  }
  // TODO: implement writeScentence
  void writeScentence(List<String> sen, [String? name, String? dir]) {
    throw UnimplementedError();
  }
}
