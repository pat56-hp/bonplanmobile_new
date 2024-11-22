import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/utils/apiEndPoint.dart';
import 'package:mobile/views/widgets/ImageWidget.dart';

class UserImage extends StatelessWidget {
  const UserImage(
      {super.key,
      required this.height,
      required this.width,
      this.borderRadius,
      this.borderColor,
      this.image});

  final double height;
  final double width;
  final double? borderRadius;
  final Color? borderColor;
  final String? image;

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
        child: image != null
            ? ImageWidget(imgUrl: ApiEndPoint.apiUrlDomaine + image!)
            : Image.asset(
                'assets/images/user.png',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
