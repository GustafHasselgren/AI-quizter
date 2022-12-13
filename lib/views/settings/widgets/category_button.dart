import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/data/game_session.dart';
import 'package:template/theme/theme.dart';

/// # Categorybutton
/// Builds a button for categories. Updates the categories selected in settings
class CategoryButton extends StatelessWidget {
  ThemeCategory category;
  CategoryButton(this.category, {super.key});

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    List tempValdaKategorier =
        Provider.of<GameSession>(context, listen: true).chosenCategories;

    Color categoryColor = category.color;
    Color iconColor = Themes.colors.white;
    double opacity = 1;
    if (!tempValdaKategorier.contains(category.name)) {
      categoryColor = Themes.functions.lightenColor(categoryColor, 40);
      opacity = 0.40;
    }
    return InkWell(
      child: Opacity(
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: Themes.functions.applyGradient(categoryColor)),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Center(
                  child: Icon(
                category.icon,
                color: iconColor,
              )),
            ),
          ),
        ),
      ),
      onTap: () {
        Provider.of<GameSession>(context, listen: false)
            .updateCategory(category.name);
        Provider.of<GameSession>(context, listen: false)
            .settings
            .checkSettings();
      },
    );
  }
}
