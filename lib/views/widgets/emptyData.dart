import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/views/widgets/textWidget.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
    required this.label
  });

  final String label;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 30),
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backgroundColorWhite,
          borderRadius:
              BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 5,
              color:
                  Color.fromARGB(35, 0, 0, 0),
            )
          ]),
      child: TextWidget(
        label: label,
      ),
    );
  }
}
