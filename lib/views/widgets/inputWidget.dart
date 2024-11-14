import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.sizeIcon,
      this.obscureText,
      this.hintTextColor,
      this.background,
      this.controller,
      this.errorText,
      this.value,
      this.readOnly = false,
      this.clickFunction});

  final bool? obscureText;
  final Function? clickFunction;
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final double? sizeIcon;
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
        if (readOnly == true) {
          clickFunction!();
        }
      },
      obscureText: obscureText ?? false,
      cursorColor: textColor,
      style: const TextStyle(color: textColor, fontSize: textSize),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  prefixIcon!,
                  color: iconColor,
                ),
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  suffixIcon!,
                  color: iconColor,
                  width: sizeIcon ?? iconSize,
                  height: sizeIcon ?? iconSize,
                ),
              )
            : null,
      ),
    );
  }
}
