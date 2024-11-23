import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/views/widgets/catLoc.dart';
import 'package:mobile/views/widgets/iconButtonWidget.dart';
import 'package:mobile/views/widgets/stars.dart';
import 'package:mobile/views/widgets/statusPlan.dart';
import 'package:mobile/views/widgets/textWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanInfoTop extends StatelessWidget {
  const PlanInfoTop({super.key, required this.etablissement});

  final Etablissement etablissement;

  //Lancer l'appel de l'etablissement
  Future<void> makePhoneContact() async {
    final Uri url = Uri(scheme: 'tel', path: etablissement.phone.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Impossible de lancer l\'appel');
    }
  }

  //Envoie de mail
  Future<void> sendEmail() async {
    final Uri url = Uri(scheme: 'mailto', path: etablissement.email);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Impossible d\'ouvrir l\'application gmail');
      sendEmailToNavigator();
    }
  }

  Future<void> sendEmailToNavigator() async {
    final Uri url = Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1&to=${etablissement.email}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print('Impossible d\'ouvrir Gmail dans le navigateur.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              label: etablissement.libelle.toString(),
              extra: const {'color': titleColor, 'fontWeight': FontWeight.w500},
            ),
            StatusPlan(
              label: etablissement.statusOuverture,
              status: etablissement.open!,
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            CatLoc(
              icon: 'assets/icons/bookmark.svg',
              label: etablissement.category.toString(),
            ),
            const SizedBox(
              width: 10,
            ),
            CatLoc(
              icon: 'assets/icons/marker.svg',
              label: etablissement.ville.toString(),
              troncate: true,
              troncateLenght: 25,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextWidget(
                    label: '${etablissement.note}.0',
                    extra: const {'color': titleColor}),
                const SizedBox(
                  width: 8,
                ),
                Stars(
                  size: 14,
                  note: etablissement.note!.toDouble(),
                )
              ],
            ),
            Row(
              children: [
                if (etablissement.email != null && etablissement.email != '')
                  IconButtonWidget(
                    backgroundColor: favorisBackground,
                    icon: 'assets/icons/envelope.svg',
                    padding: 0,
                    sizeIcon: 18,
                    borderRadius: 50,
                    pressFunction: () => sendEmail(),
                  ),
                IconButtonWidget(
                  backgroundColor: favorisBackground,
                  icon: 'assets/icons/phone.svg',
                  padding: 0,
                  sizeIcon: 18,
                  borderRadius: 50,
                  pressFunction: () => makePhoneContact(),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
