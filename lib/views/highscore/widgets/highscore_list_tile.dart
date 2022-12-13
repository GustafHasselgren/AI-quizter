import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/data/highscore.dart';
import 'package:template/theme/theme.dart';

class HighscoreListTile extends StatelessWidget {
  late Map player;
  late int index;

  HighscoreListTile(
      {super.key, required Map this.player, required int this.index});
  @override
  Widget build(BuildContext context) {
    TextStyle style = Themes.textStyle.highscoreText;
    Color tileColor = Themes.colors.white;
    double tileHeight = 30;
    if (player["key"] ==
        Provider.of<Highscore>(context, listen: false).lastKey) {
      style = Themes.textStyle.highscoreTextBold;
      tileColor = Themes.colors.yellowLight;
      tileHeight = 35;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        height: tileHeight,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 3, color: Themes.colors.blueDark),
            color: tileColor),
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 25,
              child: Text(
                textAlign: TextAlign.end,
                "${index + 1}",
                style: style,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              player["name"],
              style: style,
            ), // skall visa spelaren namn
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("${player["score"]}",
                    style: style), // skall visa highscore
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
