import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/constants/color.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.backgroundColor,
    required this.icon,
    this.padding,
    this.colorIcon,
    this.pressFunction,
    this.sizeIcon,
    this.borderRadius,
  });

  final Color backgroundColor;
  final String icon;
  final double? padding;
  final double? sizeIcon;
  final double? borderRadius;
  final Color? colorIcon;
  final Function? pressFunction;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
                horizontal: padding ?? 16, vertical: padding ?? 16),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                side: const BorderSide(color: profilBorder),
                borderRadius: BorderRadius.circular(borderRadius ?? 8)),
          ),
        ),
        onPressed: () {
          if (pressFunction != null) {
            pressFunction!(); // Appel explicite de la fonction
          }
        },
        icon: SizedBox(
          height: sizeIcon,
          child: SvgPicture.asset(
            icon,
            color: colorIcon ?? iconColor,
          ),
        ));
  }
}
