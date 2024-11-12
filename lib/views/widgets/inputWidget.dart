import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.obscureText,
      this.hintTextColor,
      this.background,
      this.controller,
      this.errorText,
      this.value,
      this.readOnly = false});

  final bool? obscureText;
  final String hintText;
  final String prefixIcon;
  final Color? background;
  final Color? hintTextColor;
  final String? errorText;
  final String? value;
  final bool readOnly;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: () {
        if (readOnly) {
          Get.toNamed('/search');
        }
      },
      obscureText: obscureText ?? false,
      cursorColor: textColor,
      style: const TextStyle(color: textColor, fontSize: textSize),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintTextColor ?? placeholderColor,
          fontSize: placeholderSize,
        ),
        // Bordure inactive
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: profilBorder, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),

        // Bordure active
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderActive, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),

        // Bordure d'erreur
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appBarBackground, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        errorText: errorText,
        errorStyle: const TextStyle(fontSize: placeholderSize),

        // Bordure quand il y a une erreur et que le champ est actif
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appBarBackground, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: background ?? drawerButton,
        filled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            prefixIcon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
