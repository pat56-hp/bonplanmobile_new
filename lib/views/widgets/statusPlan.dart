import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/views/widgets/TextWidget.dart';

class StatusPlan extends StatelessWidget {
  const StatusPlan({super.key, required this.label, required this.status});

  final String label;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: status == true ? successColor : appBarBackground,
      ),
      child: TextWidget(
        label: label,
        extra: const {'color': textWhite, 'size': otherTextSize},
      ),
    );
  }
}
