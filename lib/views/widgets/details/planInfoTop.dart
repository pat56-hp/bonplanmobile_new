import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/views/widgets/catLoc.dart';
import 'package:mobile/views/widgets/iconButtonWidget.dart';
import 'package:mobile/views/widgets/stars.dart';
import 'package:mobile/views/widgets/statusPlan.dart';
import 'package:mobile/views/widgets/textWidget.dart';

class PlanInfoTop extends StatelessWidget {
  const PlanInfoTop({super.key, required this.etablissement});

  final Etablissement etablissement;

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
            const Row(
              children: [
                IconButtonWidget(
                  backgroundColor: favorisBackground,
                  icon: 'assets/icons/envelope.svg',
                  padding: 0,
                  sizeIcon: 18,
                  borderRadius: 50,
                ),
                IconButtonWidget(
                  backgroundColor: favorisBackground,
                  icon: 'assets/icons/phone.svg',
                  padding: 0,
                  sizeIcon: 18,
                  borderRadius: 50,
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
