import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.label,
    this.extra,
  });

  final String label;
  final Map<String, dynamic>? extra;

  @override
  Widget build(BuildContext context) {
    bool isTroncate = extra?['troncate'] ?? false;
    return Text(
      isTroncate == true && label.length > (extra?['troncateLenght'] ?? 8)
          ? '${label.substring(0, extra?['troncateLenght'] ?? 8)}...'
          : label,
      maxLines: extra?['maxLines'],
      overflow: TextOverflow.visible,
      //maxLines: 2,
      softWrap: true,
      //overflow: TextOverflow.ellipsis,
      textAlign: extra?['textAlign'] ?? TextAlign.center,
      style: TextStyle(
        fontSize: extra?['size'] ?? textSize,
        color: extra?['color'] ?? textColor,
        fontWeight: extra?['fontWeight'] ?? FontWeight.normal,
      ),
    );
  }
}
