import 'package:flutter/material.dart';
import 'package:template/theme/theme.dart';
import 'package:template/views/settings/widgets/category_button.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    var themesCategory = ThemeCategories();
    List<ThemeCategory> categoryList = themesCategory.listCategories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 5),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 5,
          children: categoryList
              .map(
                (category) => CategoryButton(category),
              )
              .toList(),
        ),
      ],
    );
  }
}
