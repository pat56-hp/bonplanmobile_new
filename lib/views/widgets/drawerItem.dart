import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/views/widgets/TextWidget.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.label,
    this.onPress,
  });

  final String icon;
  final String label;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPress != null) {
          Navigator.pop(context);
          onPress!();
        }
      },
      splashColor: Colors.grey.withOpacity(0.3), // Couleur de l'effet "splash"
      highlightColor:
          Colors.grey.withOpacity(0.2), // Couleur de surbrillance lors du tap
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: iconSize,
              height: iconSize,
              color: iconColor,
            ),
            const SizedBox(
              width: 35,
            ),
            Expanded(
              child: TextWidget(
                label: label,
                extra: const {
                  'color': textColor,
                  'size': title,
                  'textAlign': TextAlign.start
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
