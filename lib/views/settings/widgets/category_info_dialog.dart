import 'package:flutter/material.dart';
import 'package:template/components/custom_button.dart';
import 'package:template/theme/theme.dart';

class InfoAboutCategories extends StatelessWidget {
  const InfoAboutCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Themes.colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(15),
      actionsPadding: const EdgeInsets.all(15),
      title: const Text('Category info:'),
      content: _categoryinfoBuilder(context),
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

  _categoryinfoBuilder(context) {
    List<ThemeCategory> ListlistCategories = Themes.categories.listCategories;
    return SizedBox(
      height: 350,
      width: 100,
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: ListlistCategories.length,
          itemBuilder: (BuildContext context, index) {
            return _categoryRow(ListlistCategories[index]);
          }),
    );
  }

  _categoryRow(ThemeCategory themeCategory) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(themeCategory.icon, color: themeCategory.color),
          SizedBox(width: 10),
          Text(themeCategory.name)
        ],
      ),
    );
  }
}
