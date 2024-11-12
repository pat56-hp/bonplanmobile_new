import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:mobile/views/widgets/textWidgetTroncate.dart';

class CatLoc extends StatelessWidget {
  const CatLoc(
      {super.key,
      required this.icon,
      required this.label,
      this.labelSize,
      this.troncate,
      this.troncateLenght = 8,
      this.iconColor,
      this.gap,
      this.fontWeight,
      this.maxLines});

  final String icon;
  final String label;
  final double? labelSize;
  final bool? troncate;
  final int troncateLenght;
  final int? maxLines;
  final Color? iconColor;
  final double? gap;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: labelSize ?? textSize,
          height: labelSize ?? textSize,
          color: iconColor ?? appBarBackground,
        ),
        SizedBox(
          width: gap ?? 5,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: TextWidget(
            label: label,
            extra: {
              'size': labelSize,
              'maxLines': maxLines,
              'troncate': troncate,
              'troncateLenght': troncateLenght,
              'fontWeight': fontWeight ?? FontWeight.normal,
              'textAlign': TextAlign.start
            },
          ),
        )
      ],
    );
  }
}
