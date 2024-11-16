import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/utils/apiEndPoint.dart';
import 'package:mobile/views/widgets/ImageWidget.dart';
import 'package:mobile/views/widgets/catLoc.dart';
import 'package:mobile/views/widgets/stars.dart';
import 'package:mobile/views/widgets/statusPlan.dart';
import 'package:mobile/views/widgets/textWidget.dart';
import 'package:mobile/views/widgets/wishlistButton.dart';

class LargePlan extends StatelessWidget {
  const LargePlan({super.key, required this.etablissement});
  final Etablissement
      etablissement; // Assurez-vous que ceci correspond au type attendu

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 270,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /** Image, Statut et boutton d'ajout en favoris **/
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed('/detailPlan', arguments: etablissement);
                },
                child: SizedBox(
                    width: 250,
                    height: 170,
                    child: ImageWidget(
                      imgUrl: ApiEndPoint.apiUrlDomaine +
                          etablissement.image.toString(),
                      borderRadius: 15.0,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusPlan(
                      label: etablissement.statusOuverture,
                      status: etablissement.open ?? false,
                    ),
                    WishlistButton(
                      etablissement: etablissement,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextWidget(
            label: etablissement.libelle.toString(),
            extra: const {
              'troncate': true,
              'troncateLenght': 20,
              'size': label,
              'color': titleColor,
              'fontWeight': FontWeight.bold
            },
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CatLoc(
                  icon: 'assets/icons/bookmark.svg',
                  label: etablissement.category.toString()),
              Stars(
                note: etablissement.note!.toDouble(),
              )
            ],
          ),
          Row(
            children: [
              CatLoc(
                icon: 'assets/icons/marker.svg',
                label: etablissement.ville.toString(),
                troncate: true,
                troncateLenght: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
