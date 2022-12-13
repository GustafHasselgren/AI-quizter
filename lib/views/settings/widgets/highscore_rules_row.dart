import 'package:flutter/material.dart';
import 'package:template/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:template/data/game_session.dart';
import 'package:template/views/settings/widgets/game_rule_dialog.dart';

class HighscoreRulesRow extends StatelessWidget {
  const HighscoreRulesRow({super.key});

  double opacityCheck(context) {
    if (Provider.of<GameSession>(context, listen: false)
            .settings
            .standardSettings ==
        false) {
      return 1;
    } else {
      return 0.4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameSession>(
      builder: (context, gameSession, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
              opacity: opacityCheck(context),
              child: Container(
                height: 45,
                width: 190,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient:
                        Themes.functions.applyGradient(Themes.colors.blueDark)),
                child: TextButton(
                  onPressed: () {
                    Provider.of<GameSession>(context, listen: false)
                        .resetSettings();
                  },
                  child: Text(
                    "Use highscore settings",
                    style: Themes.textStyle.headline3,
                  ),
                ),
              )),
          const SizedBox(width: 30),
          IconButton(
            padding: const EdgeInsets.all(0),
            icon: Icon(Icons.info_outline_rounded,
                size: 30, color: Themes.colors.white),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: ((BuildContext context) => GameRulesDialog()));
            },
          ),
        ],
      ),
    );
  }
}
