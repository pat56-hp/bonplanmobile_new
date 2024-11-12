import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';

class InputPhoneWidget extends StatefulWidget {
  const InputPhoneWidget({super.key, required this.focusNode, this.controller});

  final FocusNode focusNode;
  final TextEditingController? controller;

  @override
  State<InputPhoneWidget> createState() => _InputPhoneWidgetState();
}

class _InputPhoneWidgetState extends State<InputPhoneWidget> {
  _getPhoneNumber(phone) {
    print('Phone : ${phone.completeNumber}');
    //widget.controller?.text = phone.completeNumber;
  }

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      disableAutoFillHints: true,
      disableLengthCheck: true,
      showDropdownIcon: false,
      languageCode: "fr",
      initialCountryCode: 'CI',
      searchText: 'Rechercher un pays',
      invalidNumberMessage: 'Contact invalide',
      flagsButtonPadding: const EdgeInsetsDirectional.only(start: 16),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: 'Contact',
        hintStyle: const TextStyle(
          color: placeholderColor,
          fontSize: placeholderSize,
        ),
        // Bordure inactive
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: profilBorder, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),

        // Bordure active
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: borderActive, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),

        // Bordure d'erreur
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: appBarBackground, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),

        // Bordure quand il y a une erreur et que le champ est actif
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: appBarBackground, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: backgroundColorWhite,
        filled: true,
      ),
      onChanged: (phone) => _getPhoneNumber(phone),
      onCountryChanged: (country) {
        print('Country changed to: ' + country.name);
      },
    );
  }
}
