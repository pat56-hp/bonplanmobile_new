import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';

class BottomAuthLabel extends StatelessWidget {
  const BottomAuthLabel({
    super.key,
    required this.labelText,
    required this.clickLabel,
    required this.route,
  });

  final String labelText;
  final String clickLabel;
  final Function route;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: label),
            children: [
              TextSpan(
                text: labelText,
                style: const TextStyle(color: textColor),
              ),
              TextSpan(
                text: clickLabel,
                style: const TextStyle(
                  color: textRed,
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()..onTap = () => route(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
