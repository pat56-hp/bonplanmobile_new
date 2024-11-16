import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/constants/size.dart';

class Stars extends StatelessWidget {
  const Stars({super.key, this.size, this.note = 0.0});

  final double? size;
  final double note;

  final String sartActiveIcon = 'assets/icons/star-active.svg';
  final String sartIcon = 'assets/icons/star.svg';

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = List.generate(
      5,
      (index) => SvgPicture.asset(
        index < note ? sartActiveIcon : sartIcon,
        width: size ?? textSize,
        height: size ?? textSize,
        color: Color(0xFFFFD900),
      ),
    );
    
    return Row(
      children: [
        for (int i = 0; i < stars.length; i++) ...[
          stars[i],
          if (i < stars.length - 1) const SizedBox(width: 5),
        ]
      ],
    );
  }
}
