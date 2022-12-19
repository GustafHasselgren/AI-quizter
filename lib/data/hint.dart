import 'package:flutter/cupertino.dart';
import 'package:template/data/question.dart';
import 'package:template/data/http_request.dart';

class Hint extends ChangeNotifier {
  late String _hint;
  late String _previousHints;

  String get hint => _hint;

  String get previousHints => _previousHints;

  set hint(String newHint) {
    _hint = newHint;
  }

  void fetchHint(Question question) async {
    _previousHints = '';
    _hint = 'Loading...';
    notifyListeners();
    String hint = await HttpConection().getHint(question);

    _hint = hint.replaceAll('Hint:', '');
    notifyListeners();
  }

  void fetchFurtherHint(Question question) async {
    _hint = 'Loading...';
    notifyListeners();
    String hint =
        await HttpConection().getFurtherHint(question, _previousHints);

    String trimmedHint = hint.trim();

    _hint = trimmedHint.replaceAll('Hint:', '');
    if (_hint != '') {
      _previousHints = '$_hint, $_previousHints';
    } else {
      _hint =
          "I've spent my knowledge on this subject. Try to submit an answer!";
    }
    notifyListeners();
  }
}
