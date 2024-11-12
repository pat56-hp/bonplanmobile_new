import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/views/widgets/TextWidget.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.index,
    required this.categoryLabel,
    required int selectedCategory,
  }) : _selectedCategory = selectedCategory;

  final String categoryLabel;
  final int _selectedCategory;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          color: _selectedCategory == index
              ? appBarBackground
              : backgroundColorWhite,
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 5,
              color: Color.fromARGB(63, 0, 0, 0),
            )
          ]),
      child: TextWidget(
        label: categoryLabel,
        extra: {
          'size': textSize,
          'color': index == _selectedCategory ? textWhite : textColor
        },
      ),
    );
  }
}
