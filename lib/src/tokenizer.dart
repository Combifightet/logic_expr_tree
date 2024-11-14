import 'expr/atomic_expression.dart';

class Tokenizer {

  final Map<Type, RegExp> patterns = {
    Type.opConjunction: RegExp(r'∧'),
    Type.opDisjunction: RegExp(r'∨'),
    Type.opNegation: RegExp(r'¬'),
    Type.opEqual: RegExp(r'='),
    Type.opNotEqual: RegExp(r'≠'),
    Type.opImplication: RegExp(r'→'),
    Type.opBiimplication: RegExp(r'↔'),
    Type.opUniversalQuant: RegExp(r'∀'),
    Type.opExistentialQuant: RegExp(r'∃'),
    
    Type.tTautology: RegExp(r'⊤'),
    Type.tContradiction: RegExp(r'⊥'),
    
    Type.fRm: RegExp(r'rm'),
    Type.fLm: RegExp(r'lm'),
    Type.fFm: RegExp(r'fm'),
    Type.fBm: RegExp(r'bm'),
    
    Type.pCube: RegExp(r'Cube'),
    Type.pTet: RegExp(r'Tet'),
    Type.pDodec: RegExp(r'Dodec'),
    Type.pSmaller: RegExp(r'Smaller'),
    Type.pSmall: RegExp(r'Small'),
    Type.pMedium: RegExp(r'Medium'),
    Type.pLarger: RegExp(r'Larger'),
    Type.pLarge: RegExp(r'Large'),
    Type.pLeftOf: RegExp(r'LeftOf'),
    Type.pRightOf: RegExp(r'RightOf'),
    Type.pBackOf: RegExp(r'BackOf'),
    Type.pFrontOf: RegExp(r'FrontOf'),
    Type.pSameSize: RegExp(r'SameSize'),
    Type.pSameShape: RegExp(r'SameShape'),
    Type.pSameRow: RegExp(r'SameRow'),
    Type.pSameCol: RegExp(r'SameCol'),
    Type.pAdjoins: RegExp(r'Adjoins'),
    Type.pBetween: RegExp(r'Between'),

    Type.tConstant: RegExp(r'[a-m]'),
    Type.tVariable: RegExp(r'[n-z]'),

    Type.uBracketOpen: RegExp(r'\(') ,
    Type.uBracketClose: RegExp(r'\)'),
    Type.uComma: RegExp(r','),
  };

  String _input;
  String _text='';
  Type? _id;

  Tokenizer(this._input);

  void setInput(String input) => _input = input;
  String matchedText() => _text;
  Type matchedTokenId() {
    if (_id==null) {throw Exception('nothing has been parsed');}
    return _id!;
  }
  String remainder() => _input;
  bool endOfInput() => _input.isEmpty;

  Type? next() {
    if (_input.trim().isEmpty) { // end of input
      _id = Type.uEndOfInput;
      _text = '';
      return _id;
    }

    for (RegExp pattern in patterns.values) {
      _input=_input.trim();
      if (_input.startsWith(pattern)) {
        _id = patterns.keys.firstWhere((p) => patterns[p]==pattern);
        _text = _input.substring(0, pattern.firstMatch(_input)!.end);
        _input = _input.substring(_text.length);
        return _id;
      }
    }

    throw Exception('no match found for: \'$_input\'');
  }


  main() {
    print('\nTokenizer test:\n');
    Tokenizer t = Tokenizer('⊥∨(x∀Cube(x))');

    print('input = \'${t.remainder()}\'');

    while (t.next()!=null) {
      print('next token id = ${t.matchedTokenId()}');
      print('matched text = \'${t.matchedText()}\'');
      print('remaining input = \'${t.remainder()}\'');
    }
  }
}