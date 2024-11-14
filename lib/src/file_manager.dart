import 'dart:convert';

import 'fol_world.dart';

class FileManager {
  FileManager();

  FolWorld parseWorld(dynamic data) {
    assert (data is String || data is List<int>);
    late final dynamic jsonData;
    if (data is String) {
      jsonData = json.decode(data);
    } else {
      String jsonString = Utf8Decoder().convert(data);
      jsonData = json.decode(jsonString);
    }
    FolWorld world = FolWorld();
    for(dynamic wld in jsonData) {
      List<String> consts = [];
      for (String c in wld['Consts']) {
        consts.add(c);
      }
      world.createObj(
        wld['Tags'][0],
        wld['Tags'][1],
        wld['Predicates'][0]=='Tet'
          ? ObjectType.Tet
          : wld['Predicates'][0]=='Cube'
            ? ObjectType.Cube
            : ObjectType.Dodec,
        wld['Predicates'][1]=='Small'
          ? ObjectSize.Small
          : wld['Predicates'][1]=='Medium'
            ? ObjectSize.Medium
            : ObjectSize.Large,
        consts
      );
    }
    return world;
  }

  List<String> parseSentence(dynamic data) {
    assert (data is String || data is List<int>);
    late final dynamic jsonData;
    if (data is String) {
      jsonData = json.decode(data);
    } else {
      String jsonString = Utf8Decoder().convert(data);
      jsonData = json.decode(jsonString);
    }
    List<String> sentences = [];
    for (String sen in jsonData) {
      sentences.add(sen);
    }
    return sentences;
  }
}
