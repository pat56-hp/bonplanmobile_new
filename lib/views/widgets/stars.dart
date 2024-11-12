import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';

class Stars extends StatefulWidget {
  const Stars({super.key, this.size, this.note = 3.0});

  final double? size;
  final double note;

  @override
  State<Stars> createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  String sartActiveIcon = 'assets/icons/star-active.svg';
  String sartIcon = 'assets/icons/star.svg';
  List<Widget> stars = [];

  @override
  void initState() {
    super.initState();
    stars = List.generate(
      5,
      (index) => SvgPicture.asset(
        index < widget.note ? sartActiveIcon : sartIcon,
        width: widget.size ?? textSize,
        height: widget.size ?? textSize,
        color: iconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
