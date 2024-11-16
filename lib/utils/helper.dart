import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/views/widgets/buttonWidget.dart';
import 'package:mobile/views/widgets/textWidget.dart';

//Recuperation et affichage des erreurs 422 de l'api
void showErrors(errors) {
  String errorMessages = '';

  for (var entry in errors.entries) {
    // Vérifie que la clé est une String et que la valeur est une List contenant des String
    if (entry.key is String &&
        entry.value is List &&
        entry.value.isNotEmpty &&
        entry.value[0] is String) {
      String key = entry.key;
      String errorMessage = entry.value[0];

      errorMessages = '$errorMessages$key: $errorMessage \n';
    }
  }

  //Affichage du dialog
  showDialogWidget('Oups !', errorMessages);
}

//Dialog widget
void showDialogWidget(String title, String content) {
  Get.defaultDialog(
    backgroundColor: backgroundColorWhite,
    title: title,
    titlePadding: const EdgeInsets.symmetric(vertical: 15),
    titleStyle: const TextStyle(
      fontSize: subtitle,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    //middleText: content,
    middleTextStyle: const TextStyle(
      fontSize: textSize,
      color: textColor,
    ),
    content: Column(
      children: [TextWidget(label: content)],
    ),
    confirm: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ButtonWidget(label: 'Compris', onPress: () => Get.back()),
    ),
    barrierDismissible:
        false, // Empêche de fermer le dialogue en cliquant à l'extérieur
  );
}

void showSnackBarWidget({
  String type = 'info',
  required String content,
}) {
  Color backgroundColor;
  Color contentColor;
  String title = 'Info';
  Icon icon;

  switch (type) {
    case 'error':
      backgroundColor = appBarBackground;
      title = 'Erreur';
      contentColor = textWhite;
      icon = const Icon(Icons.error, color: textWhite);
      break;

    case 'success':
      backgroundColor = successColorInfo;
      title = 'Succès';
      contentColor = textWhite;
      icon = const Icon(Icons.check_circle, color: textWhite);
      break;

    default:
      backgroundColor = backgroundColorWhite;
      contentColor = textColor;
      icon = const Icon(Icons.info, color: textColor);
      break;
  }

  Get.snackbar(
    backgroundColor: backgroundColor,
    colorText: contentColor,
    icon: icon,
    title,
    content,
  );
}
