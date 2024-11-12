import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/views/widgets/CatLoc.dart';
import 'package:mobile/views/widgets/IconButtonWidget.dart';
import 'package:mobile/views/widgets/TextWidget.dart';

class PlanEmplacement extends StatelessWidget {
  const PlanEmplacement({super.key, required this.etablissement});

  final Etablissement etablissement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
            label: 'Emplacement & Réseaux sociaux',
            extra: {'color': titleColor, 'fontWeight': FontWeight.w500}),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 155,
          decoration: BoxDecoration(
              border: Border.all(color: favorisBackground, width: 0.8),
              borderRadius: BorderRadius.circular(25)),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CatLoc(
                icon: 'assets/icons/marker.svg',
                label: '${etablissement.ville} Abidjan',
                maxLines: 2,
              ),
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
        )
      ],
    );
  }
}
