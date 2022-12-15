import 'package:flutter/cupertino.dart';
import 'package:template/data/question.dart';
import 'package:template/data/http_request.dart';

class Hint extends ChangeNotifier {
  late String _hint;
  List<String> previousHints = [];

  String get hint => _hint;

  set hint(String newHint) {
    _hint = newHint;
  }

  void fetchHint(Question question) async {
    _hint = 'Loading...';
    String hint = await HttpConection().getHint(question);

    _hint = hint;
    notifyListeners();
  }

  void fetchFurtherHint(Question question, previousHints) async {
    previousHints.add(_hint);
    _hint = 'Loading...';
    String hint = await HttpConection().getFurtherHint(question, previousHints);

    _hint = hint;
    notifyListeners();
  }
}
