import 'dart:collection';

import 'expr/comma.dart';
import 'expr/predicates/predicate.dart';
import 'expr/functions/functions.dart';
import 'expr/operators/operator.dart';
import 'expr/terminals/terminal.dart';
import 'expr/atomic_expression.dart';
import 'expr/expression_tree.dart';
import 'tokenizer.dart';


class ExpressionParser {
  late Tokenizer _scanner;
  bool _isVerbose = false;

  ExpressionTree parse(String input) {
    _scanner = Tokenizer(input);
    _scanner.next(); // use as "lookahead"
    ExpressionTree tree = _expression(0);
    _expect(Type.uEndOfInput, "<end of input>");
    return tree;
  }

  void setVerbose(bool v) => _isVerbose=v;

  String _errorNear() => "near '${_scanner.matchedText()}'\nbefore '${_scanner.remainder()}'";

  Type _lookahead() => _scanner.matchedTokenId();

  void _nextToken() => _scanner.next();

  String _matchedText() => _scanner.matchedText();

  void _expect(Type? tokenid, String text) {
    if (_lookahead()!=tokenid) {
      throw Exception("expected '$text' got '${_scanner.matchedText()}'\nbefore '${_scanner.remainder()}");
    }
  }

  void _verbose(int level,String message) {
    if (_isVerbose) {
      print("${'  '*level}$message ['${_scanner.matchedText()}','${_scanner.remainder()}']");
    }
  }

  //
  // Here is the implementation of BNF rules as methods:
  //

  /// parse expression
  /// <pre><code>expression ::= junction</code></pre> 
  ExpressionTree _expression(int level) {
    _verbose(level,"<expression>");
    return _junction(level+1);
  }

  
  /// parse junction<p>
  /// <pre><code>junction ::= comparision |
  ///     junction  '∧' comparision | junction '∨' comparision
  /// </code></pre>
  ExpressionTree _junction(int level) {
    _verbose(level,"<junction>");

    // temporary storage
    Queue<ExpressionTree> expr = Queue<ExpressionTree>();
    Queue<Type>           op   = Queue<Type>();

    ExpressionTree tree=_comparision(level+1);

    // parse iteratively
    while (_lookahead()==Type.opConjunction || _lookahead()==Type.opDisjunction) {
      op.add(_lookahead());
      _nextToken();
      expr.add(_comparision(level+1));
    }

    // setup tree
    while (op.isNotEmpty) {
      if (op.removeFirst()==Type.opConjunction) {
        tree=ExpressionTree(Conjunction(),tree,expr.removeFirst());
      } else {
        tree=ExpressionTree(Disjunction(),tree,expr.removeFirst());
      }
    }
    return tree;
  }

  /// parse comparision<p>
  /// <pre><code>comparision ::= implication |
  ///     comparision '=' implication | comparision '≠' implication
  /// </code></pre>
  ExpressionTree _comparision(int level) {
    _verbose(level,"<comparision>");

    ExpressionTree left=_implication(level+1);

    if (_lookahead()==Type.opEqual) {
      _nextToken();
      ExpressionTree right=_comparision(level+1);
      return ExpressionTree(Equal(),left,right);
    }
    else if (_lookahead()==Type.opNotEqual) {
      _nextToken();
      ExpressionTree right=_comparision(level+1);
      return ExpressionTree(NotEqual(),left,right);
    }

    return left;
  }

  /// parse implication<p>
  /// <pre><code>implication ::= comma |
  ///     implication '→' comma | implication '↔' comma
  /// </code></pre>
  ExpressionTree _implication(int level) {
    _verbose(level,"<implication>");

    // temporary storage
    Queue<ExpressionTree> expr = Queue<ExpressionTree>();
    Queue<Type>           op   = Queue<Type>();

    ExpressionTree tree=_comma(level+1);

    // parse iteratively
    while (_lookahead()==Type.opImplication || _lookahead()==Type.opBiimplication) {
      op.add(_lookahead());
      _nextToken();
      expr.add(_comma(level+1));
    }

    // setup tree
    while (op.isNotEmpty) {
      if (op.removeFirst()==Type.opImplication) {
        tree = ExpressionTree(Implication(),tree,expr.removeFirst());
      } else {
        tree = ExpressionTree(Biimplication(),tree,expr.removeFirst());
      }
    }
    return tree;
  }

  // /// parse quantor<p>
  // /// <pre><code>quantor ::= terminal |
  // ///     terminal '∀' expression | terminal '∃' expression
  // /// </code></pre>
  // ExpressionTree _quantor(int level) {
  //   _verbose(level,"<quantor>");

  //   // temporary storage
  //   Queue<ExpressionTree> expr = Queue<ExpressionTree>();
  //   Queue<Type>           op   = Queue<Type>();

  //   ExpressionTree tree=_comma(level+1);

  //   // parse iteratively
  //   while (_lookahead()==Type.opUniversalQuant || _lookahead()==Type.opExistentialQuant) {
  //     op.add(_lookahead());
  //     _nextToken();
  //     expr.add(_expression(level+1));
  //   }

  //   // setup tree
  //   while (op.isNotEmpty) {
  //     if (op.removeFirst()==Type.opUniversalQuant) {
  //       tree = ExpressionTree(UniversalQuant(),tree,expr.removeFirst());
  //     } else {
  //       tree = ExpressionTree(ExistentialQuant(),tree,expr.removeFirst());
  //     }
  //   }
  //   return tree;
  // }

  ExpressionTree _comma(int level) {
    _verbose(level, '<comma>');

    ExpressionTree left = _terminal(level+1);
    if (_lookahead()==Type.uComma) {
      _nextToken();
      ExpressionTree right = _comma(level+1);
      return ExpressionTree(Comma(), left, right);
    }
    return left;
  }

  /// parse terminal<p>
  /// <pre><code>terminal ::= '⊤' | '⊥' | symbol | predicate terminal |
  ///     function terminal | '(' expression ')' | '¬' terminal
  /// </code></pre>

  /// The last part of the rule corresponds to <em>unary</em> not 
  /// operator ¬x.
  ExpressionTree _terminal(int level) {
    _verbose(level,"<terminal>");

    ExpressionTree? tree;
    if (_lookahead()==Type.tConstant) {
      tree = ExpressionTree(Constant(_matchedText()[0]));
    } else if (_lookahead()==Type.tVariable) {
      tree = ExpressionTree(Variable(_matchedText()[0]));
    } else if (_lookahead()==Type.tTautology) {
      tree = ExpressionTree(Tautology());
    } else if (_lookahead()==Type.tContradiction) {
      tree = ExpressionTree(Contradiction());
    }
    else if (_lookahead().isPredicate()) {
      Predicate p = predicates[_lookahead()]!;
      _nextToken();
      return ExpressionTree(p, _terminal(level+1));
    } else if (_lookahead().isFunction()) {
      Functions f = functions[_lookahead()]!;
      _nextToken();
      return ExpressionTree(f, _terminal(level+1));
    }
    else if (_lookahead()==Type.opUniversalQuant) {
      _nextToken();
      ExpressionTree left = _terminal(level+1);
      ExpressionTree right = _expression(level+1);
      return ExpressionTree(UniversalQuant(), left, right);
    } else if (_lookahead()==Type.opExistentialQuant) {
      _nextToken();
      ExpressionTree left = _terminal(level+1);
      ExpressionTree right = _expression(level+1);
      return ExpressionTree(ExistentialQuant(), left, right);
    }
    else if (_lookahead()==Type.uBracketOpen) {
      _nextToken();
      tree = _expression(level+1);
      _expect(Type.uBracketClose,"closing parenthesis )");
    }
    else if (_lookahead()==Type.opNegation) {
      _nextToken();
      tree = ExpressionTree(Negation(), _expression(level+1));
    }
    else {
      throw ArgumentError(_errorNear());
    }

    _nextToken();
    return tree;
  }




  void main() {
    String input = '⊥∨(∀xCube(x))';
    input = '¬⊥';
    print('input = \'$input\'');

    ExpressionParser p = ExpressionParser();
    p.setVerbose(true);
    ExpressionTree tree = p.parse(input);

    print('output = \'$tree\'');

    // print(tree.postorder().toString());

    print(tree.toTikZ());
  }
}