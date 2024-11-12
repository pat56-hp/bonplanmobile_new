import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';

class LoadingCircularProgress extends StatelessWidget {
  const LoadingCircularProgress({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        //backgroundColor: backgroundColor,
        color: color ?? backgroundColor,
      ),
    );
  }
}
