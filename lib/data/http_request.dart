import 'dart:convert';

import 'package:http/http.dart' as http;
import 'settings.dart';
import 'question.dart';
import 'package:template/auth/top_secret.dart';

class HttpConection {
  late Settings settings;
  final String url = 'https://the-trivia-api.com/api/questions';
  // Huge thanks to Will Fry who created this open API!

  //
  final String openAiKey = myOpenAiKey;
  final String aiUrl = 'https://api.openai.com/v1/completions';

  Map<String, String> listCategories = {
    "Food & Drink": "food_and_drink",
    "General Knowledge": "general_knowledge",
    "Film & TV": "film_and_tv",
    "Arts & Literature": "arts_and_literature",
    "Geography": "geography",
    "History": "history",
    "Music": "music",
    "Science": "science",
    "Society & Culture": "society_and_culture",
    "Sport & Leisure": "sport_and_leisure"
  };

  /// Gets a set of answers from the trivia Api. This function recuires
  /// an object of setting that contains game settings. It returns a
  /// complete list of Question objects.
  Future getQuestions({required Settings settings}) async {
    List<Question> questionList = [];
    int index = 0;
    String path =
        '?${_pathToCategorys(settings)}${_pathToDifficulty(settings)}${_pathToNumberOfQuestions(settings)}';
    http.Response response = await http.get(Uri.parse('$url$path'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      for (var question in data) {
        questionList.add(Question.fromJson(question, index));
        index += 1;
      }
    }
    return questionList;
  }

  String _pathToDifficulty(Settings settings) {
    return '&difficulty=${settings.difficulty}';
  }

  String _pathToCategorys(Settings settings) {
    if (settings.categories.isEmpty) {
      return "";
    }
    String categories = '&categories=';
    for (String category in settings.categories) {
      categories += '${listCategories[category]},';
    }
    return categories.substring(0, categories.length - 1);
  }

  String _pathToNumberOfQuestions(Settings settings) {
    if (settings.numberOfQuestions > 0) {
      return '&limit=${settings.numberOfQuestions}';
    }
    return '&limit=10';
  }

  Future getMetadata() async {
    http.Response response =
        await http.get(Uri.parse('https://the-trivia-api.com/api/metadata'));
    Map map = jsonDecode(response.body);
    return map;
  }

  Future getHint(Question question) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $openAiKey',
      'Content-Type': 'Application/json'
    };

    String stringQuestion = question.question;
    String answer = question.correctAnswer;

    String body = jsonEncode({
      'model': 'text-davinci-003',
      'prompt':
          'Give a hint to the question. DO NOT include the correct answer in the hint. Question: $stringQuestion. Correct answer: $answer',
      'temperature': 0.6,
      'max_tokens': 50
    });

    http.Response response =
        await http.post(Uri.parse(aiUrl), headers: headers, body: body);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      String hint = data['choices'][0]['text'];
      return hint;
    } else {
      print(response.headers);
      return 'Something went wrong. ${response.statusCode.toString()}';
    }
  }

  Future getFurtherHint(Question question, List<String> previousHints) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $openAiKey',
      'Content-Type': 'Application/json'
    };

    String stringQuestion = question.question;
    String answer = question.correctAnswer;
    List<String> hints = previousHints;

    String body = jsonEncode({
      'model': 'text-davinci-003',
      'prompt':
          'Give a hint to the question. DO NOT include the correct answer in the hint. Question: $stringQuestion. Correct answer: $answer. DO NOT include these hints: $hints',
      'temperature': 0.6,
      'max_tokens': 50
    });

    http.Response response =
        await http.post(Uri.parse(aiUrl), headers: headers, body: body);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      String hint = data['choices'][0]['text'];
      return hint;
    } else {
      print(response.body);
      return 'Something went wrong. ${response.statusCode.toString()}';
    }
  }
}
