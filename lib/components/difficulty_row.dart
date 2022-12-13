import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/components/custom_button.dart';
import 'package:template/data/game_session.dart';
import 'package:template/data/highscore.dart';
import 'package:template/theme/theme.dart';

/// To make this work both for Settings view and HighscoreView the bool isSettingsView must be used.
/// If used in settingsView set to True. If in HighscoreView set to False. It is to change de functionality
/// of the buttons and will only work for settings and highscore as is.
class DifficultyRow extends StatelessWidget {
  late bool isSettingsView = true;

  DifficultyRow({super.key, required this.isSettingsView});
  @override
  Widget build(BuildContext context) {
    String difficulty =
        Provider.of<GameSession>(context, listen: true).chosenDifficulty;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _difficultyButton(
          context,
          "Easy",
          difficulty,
          Themes.colors.green,
        ),
        const SizedBox(width: 20),
        _difficultyButton(
          context,
          "Medium",
          difficulty,
          Themes.colors.yellow,
        ),
        const SizedBox(width: 20),
        _difficultyButton(
          context,
          "Hard",
          difficulty,
          Themes.colors.red,
        ),
      ],
    );
  }

  Widget _difficultyButton(
      context, String newDifficulty, String setDifficulty, color) {
    double opacity = 0.4;
    if (newDifficulty.toLowerCase() == setDifficulty) {
      opacity = 1;
    }
    return Opacity(
      opacity: opacity,
      child: CustomButton(
          text: Text(newDifficulty, style: Themes.textStyle.headline3),
          width: 80,
          height: 40,
          color: color,
          onPressed: () {
            // If isSettingsView makes the function update the selected difficulty
            if (isSettingsView) {
              Provider.of<GameSession>(context, listen: false).updateDifficulty(
                newDifficulty.toLowerCase(),
              );
            }
            // If not isSettingsView makes the function change the viewed difficulty in the highscoreview.
            else {
              Provider.of<Highscore>(context, listen: false)
                  .setDifficultyToView(newDifficulty.toLowerCase());
              Provider.of<Highscore>(context, listen: false)
                  .fetchScores(difficulty: newDifficulty.toLowerCase());
            }
          }),
    );
  }
}
