import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';

class UserImage extends StatelessWidget {
  const UserImage(
      {super.key,
      required this.height,
      required this.width,
      this.borderRadius,
      this.borderColor});

  final double height;
  final double width;
  final double? borderRadius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 28),
        border: Border.all(color: borderColor ?? borderImage, width: 1.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 28),
        child: Image.asset(
          'assets/images/user.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
