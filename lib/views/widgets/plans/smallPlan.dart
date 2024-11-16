import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/utils/apiEndPoint.dart';
import 'package:mobile/views/widgets/CatLoc.dart';
import 'package:mobile/views/widgets/ImageWidget.dart';
import 'package:mobile/views/widgets/Stars.dart';
import 'package:mobile/views/widgets/StatusPlan.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:mobile/views/widgets/wishlistButton.dart';

class SmallPlan extends StatelessWidget {
  const SmallPlan({super.key, required this.plan});

  final Etablissement plan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/detailPlan', arguments: plan),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: backgroundColorWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 5,
                color: Color.fromARGB(35, 0, 0, 0),
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 68,
                  width: 82,
                  child: ImageWidget(
                    imgUrl: ApiEndPoint.apiUrlDomaine + plan.image.toString(),
                    borderRadius: 15.0,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: WishlistButton(
                    etablissement: plan,
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /** Libelle et etoiles avis **/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextWidget(
                          label: plan.libelle.toString(),
                          extra: const {
                            'troncate': true,
                            'troncateLenght': 15,
                            'color': titleColor,
                            'fontWeight': FontWeight.bold,
                            'textAlign': TextAlign.start
                          },
                        ),
                      ),
                      Stars(
                        size: iconSmall,
                        note: plan.note!.toDouble(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  /** Categorie et emplacement **/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CatLoc(
                              troncate: true,
                              icon: 'assets/icons/bookmark.svg',
                              label: plan.category.toString(),
                              labelSize: textSmall),
                          const SizedBox(
                            width: 8,
                          ),
                          CatLoc(
                            icon: 'assets/icons/marker.svg',
                            label: plan.ville.toString(),
                            labelSize: textSmall,
                            troncate: true,
                          ),
                        ],
                      ),
                      StatusPlan(
                          label: plan.statusOuverture, status: plan.open!)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
