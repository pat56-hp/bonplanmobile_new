import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:flutter/gestures.dart';

class TextWidgetTroncate extends StatefulWidget {
  const TextWidgetTroncate({super.key, required this.text, this.maxLines});

  final String text;
  final int? maxLines;

  @override
  State<TextWidgetTroncate> createState() => _TextWidgetTroncateState();
}

class _TextWidgetTroncateState extends State<TextWidgetTroncate> {
  bool isExpanded = false;

  void toggleExpanded(text) {
    setState(() {
      isExpanded = !isExpanded;
      print(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(fontSize: textSize, color: textColor),
          children: [
            TextSpan(
              text: isExpanded
                  ? '${widget.text} '
                  : widget.text.length > (widget.maxLines ?? 100)
                      ? '${widget.text.substring(0, widget.maxLines ?? 100)}...'
                      : widget.text,
            ),
            if (widget.text.length > (widget.maxLines ?? 100))
              TextSpan(
                text: isExpanded ? null : 'Voir plus',
                style: const TextStyle(color: textRed),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => toggleExpanded(widget.text),
              )
          ]),
    );
  }
}
