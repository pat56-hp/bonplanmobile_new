import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/views/widgets/TextWidget.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key, required this.label, this.labelSize, this.backgroundColor, this.iconWidget, this.onPress});

  final String label;
  final double? labelSize;
  final Color? backgroundColor;
  final Widget? iconWidget;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                backgroundColor ?? buttonDefaultColor),
            side: MaterialStateProperty.all(BorderSide.none),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)))),
        onPressed: (){
          if (onPress != null) {
            onPress!(); // Appel explicite de la fonction
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget ?? const SizedBox.shrink(),
            TextWidget(
              label: label,
              extra: {'color': textWhite, 'size': labelSize ?? subtitle},
            ),
          ],
        ));
  }
}
