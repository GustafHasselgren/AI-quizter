import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:provider/provider.dart';
import 'package:template/components/custom_button.dart';
import 'package:template/data/game_session.dart';
import 'package:template/theme/theme.dart';
import 'package:template/views/loading_view.dart';
import 'package:template/views/settings/widgets/category_row.dart';
import 'package:template/components/difficulty_row.dart';
import 'package:template/views/settings/widgets/highscore_rules_row.dart';
import 'package:template/components/backbutton.dart';
import 'package:template/components/slider.dart';

import 'widgets/category_info_dialog.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      child: (Center(
          child: Consumer<GameSession>(
        builder: (BuildContext context, gameSession, child) => Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 20, child: BackToFirstViewButton()),
                Expanded(
                  child: Text(
                    'Singleplayer',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Themes.colors.white, fontSize: 35),
                  ),
                ),
                const SizedBox(width: 20)
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            _menuDescriptioTextAndInfoButton(context, "Categories"),
            const SizedBox(
              height: 5,
            ),
            const CategoryRow(),
            const SizedBox(
              height: 20,
            ),
            _menuDescriptionText(text: 'Number of questions'),
            const SizedBox(
              height: 5,
            ),
            _numberOfQuestionsSlider(gameSession),
            const SizedBox(
              height: 20,
            ),
            _menuDescriptionText(text: 'Time per question'),
            const SizedBox(
              height: 5,
            ),
            _timePerQuestionSlider(gameSession),
            const SizedBox(
              height: 20,
            ),
            _menuDescriptionText(text: 'Difficulty'),
            const SizedBox(
              height: 5,
            ),
            DifficultyRow(isSettingsView: true),
            const SizedBox(
              height: 20,
            ),
            const HighscoreRulesRow(),
            const Spacer(),
            _startButton(gameSession, context),
            const Spacer(),
          ],
        ),
      ))),
    );
  }

  SliderModel _timePerQuestionSlider(GameSession gameSession) {
    return SliderModel(
        onchanged: gameSession.updateTimePerQuestion,
        getValue: gameSession.getTimePerQuestion,
        displayInCircle: getTimePerQuestionSlider(gameSession),
        max: 61);
  }

  SliderModel _numberOfQuestionsSlider(GameSession gameSession) {
    return SliderModel(
        onchanged: gameSession.updateNumberOfQuestion,
        getValue: gameSession.getNumberOfQuestion,
        displayInCircle: getNumberOfQuestionSlider(gameSession),
        max: 50);
  }

  Align _menuDescriptionText({required String text}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        text,
        style: TextStyle(color: Themes.colors.white, fontSize: 15),
      ),
    );
  }

  Row _menuDescriptioTextAndInfoButton(context, text) {
    return Row(
      children: [
        _menuDescriptionText(text: text),
        IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(Icons.info_outline_rounded,
              size: 30, color: Themes.colors.white),
          onPressed: () {
            showDialog(
                context: context,
                builder: ((BuildContext context) =>
                    const InfoAboutCategories()));
          },
        ),
      ],
    );
  }

  CustomButton _startButton(GameSession gameSession, BuildContext context) {
    return CustomButton(
      text: Text(
        "Start",
        style: Themes.textStyle.headline1,
      ),
      onPressed: () {
        gameSession.settings.checkSettings();
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, _, __) => LoadingView(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
      },
      width: 250,
      height: 50,
      color: Themes.colors.blueDark,
    );
  }

  Widget getTimePerQuestionSlider(gameSession) {
    double number = gameSession.getTimePerQuestion();
    if (number == 61) {
      return Icon(
        OctIcons.infinity_16,
        size: 15,
        color: Themes.colors.white,
      );
    } else {
      return Text(number.round().toString(),
          style: TextStyle(color: Themes.colors.white));
    }
  }

  Widget getNumberOfQuestionSlider(gameSession) {
    return Text(gameSession.getNumberOfQuestion().round().toString(),
        style: TextStyle(color: Themes.colors.white));
  }
}
