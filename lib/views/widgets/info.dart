import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/views/widgets/catLoc.dart';
import 'package:mobile/views/widgets/TextWidget.dart';

class Info extends StatelessWidget {
  const Info(
      {super.key,
      required this.icon,
      required this.label,
      required this.labelValue,
      this.border});

  final String icon;
  final String label;
  final String labelValue;
  final bool? border;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: CatLoc(
              icon: icon,
              iconColor: textColor,
              gap: 15,
              label: label,
              fontWeight: FontWeight.w500,
            )),
            Expanded(
                child: TextWidget(
              label: labelValue,
              extra: const {'textAlign': TextAlign.start},
            )),
          ],
        ),
        border == true
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                height: 0.8,
                color: profilBorder)
            : const SizedBox.shrink()
      ],
    );
  }
}
