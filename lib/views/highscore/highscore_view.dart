import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/components/backbutton.dart';
import 'package:template/components/difficulty_row.dart';
import 'package:template/data/highscore.dart';
import 'package:template/theme/theme.dart';
import 'package:template/views/loading_view.dart';

import '../../components/custom_button.dart';
import 'widgets/highscore_list_tile.dart';

class HighscoreView extends StatelessWidget {
  final _controller = ScrollController();
  late bool showPlayAgain = false;

  HighscoreView({super.key, required this.showPlayAgain});
  @override
  Widget build(BuildContext context) {
    Provider.of<Highscore>(context, listen: true).fetchScores();
    return ScaffoldWithBackground(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20, child: _backToMenu(context)),
              Expanded(
                child: Text(
                  'Highscore',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Themes.colors.white, fontSize: 35),
                ),
              ),
              const SizedBox(width: 20)
            ],
          ),
          const SizedBox(height: 15),
          DifficultyRow(isSettingsView: false),
          const SizedBox(height: 15),
          _highscoreListBuilder(context),
          _playAgainButton(context),
          const SizedBox(height: 15),
          _backToMenu(context),
        ],
      ),
    );
  }

  Widget _backToMenu(context) {
    return !showPlayAgain ? const BackToFirstViewButton() : Container();
  }

  Widget _playAgainButton(context) {
    if (showPlayAgain) {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: CustomButton(
          text: Text(
            "Play again",
            style: Themes.textStyle.headline2,
          ),
          width: 250,
          height: 50,
          color: Themes.colors.blueDark,
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, _, __) => LoadingView(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero));
          },
        ),
      );
    } else {
      return Container();
    }
  }

  // Uses HigscoreListTile to produce a nice looking highscore list.
  Widget _highscoreListBuilder(context) {
    List currentList =
        Provider.of<Highscore>(context, listen: true).getChosenHighscores();
    return Expanded(
      child: FadingEdgeScrollView.fromScrollView(
        child: ListView.builder(
          controller: _controller,
          padding: const EdgeInsets.all(8),
          itemCount: currentList.length,
          itemBuilder: (BuildContext context, index) {
            return HighscoreListTile(player: currentList[index], index: index);
          },
        ),
      ),
    );
  }
}
