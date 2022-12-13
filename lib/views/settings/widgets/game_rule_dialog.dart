import 'package:flutter/material.dart';
import 'package:template/components/custom_button.dart';
import 'package:template/data/settings.dart';
import 'package:template/theme/theme.dart';

//ALERTDIALOG MED INFO FÖR ATT KUNNA FÅ RESULTAT PÅ HIGHSCORE-LISTAN
class GameRulesDialog extends StatelessWidget {
  const GameRulesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Settings newSettings = Settings();
    int questions = newSettings.numberOfQuestions;
    int time = newSettings.timePerQuestion;
    final highscoreRules =
        '''To be able to get your result on the highscore list you must use default settings.
  
Default settings are:
All categories
$questions questions
$time sec time limit

You can change the difficulty.
   ''';
    return AlertDialog(
      backgroundColor: Themes.colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(15),
      actionsPadding: const EdgeInsets.all(15),
      title: const Text('Highscore info'),
      content: Text(highscoreRules),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                text: Text('Return', style: Themes.textStyle.headline3),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                width: 100,
                height: 30,
                color: Themes.colors.blueDark),
          ],
        ),
      ],
    );
  }
}
