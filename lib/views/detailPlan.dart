import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/utils/apiEndPoint.dart';
import 'package:mobile/views/widgets/ButtonWidget.dart';
import 'package:mobile/views/widgets/IconButtonWidget.dart';
import 'package:mobile/views/widgets/ImageWidget.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:mobile/views/widgets/TextWidgetTroncate.dart';
import 'package:mobile/views/widgets/WishlistButton.dart';
import 'package:mobile/views/widgets/details/commoditeHoraire.dart';
import 'package:mobile/views/widgets/details/galley.dart';
import 'package:mobile/views/widgets/details/planEmplacement.dart';
import 'package:mobile/views/widgets/details/planInfoTop.dart';
import 'package:mobile/views/widgets/details/avisCommentaire.dart';
import 'package:html/parser.dart' show parse;

class DetailPlan extends StatefulWidget {
  const DetailPlan({super.key});

  @override
  State<DetailPlan> createState() => _DetailPlanState();
}

class _DetailPlanState extends State<DetailPlan> {
  @override
  Widget build(BuildContext context) {
    final Etablissement etablissement = Get.arguments;
    var document = parse(etablissement.description.toString());
    String description = document.body?.text ?? '';

    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height * 0.60),
          width: double.infinity,
          child: ImageWidget(
            imgUrl: ApiEndPoint.apiUrlDomaine + etablissement.image.toString(),
          ),
        ),
        Positioned(
          top: 60,
          left: 18,
          right: 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButtonWidget(
                backgroundColor: buttonColor,
                icon: 'assets/icons/icon-left.svg',
                padding: 10,
                pressFunction: () => Navigator.of(context).pop(),
              ),
              const WishlistButton()
            ],
          ),
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.6, // Hauteur initiale (30% de l'écran)
            minChildSize: 0.58, // Hauteur minimale (20% de l'écran)
            maxChildSize: 0.8, // Hauteur maximale (80% de l'écran)
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: backgroundColorWhite,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: padding, vertical: 12),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          height: 4,
                          width: 70,
                          color: profilBorder,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: [
                                  //INFORMATIONS SUR LA CATEGORIE; LE STATUT; LA NOTE; LA CATEGORIE
                                  PlanInfoTop(etablissement: etablissement),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  PlanEmplacement(etablissement: etablissement),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextWidget(
                                          label: 'Description',
                                          extra: {
                                            'color': titleColor,
                                            'fontWeight': FontWeight.w500
                                          }),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextWidgetTroncate(
                                        text: description,
                                        maxLines: 140,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  if (etablissement.gallery!.isNotEmpty)
                                    Column(
                                      children: [
                                        GalleryWidget(
                                          gallery: etablissement.gallery!,
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                    ),
                                  CommoditeHoraire(
                                    commodite: etablissement.commodites,
                                    horaire: etablissement.horaire,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  if (etablissement.commentaires!.isNotEmpty)
                                    Column(children: [
                                      AvisCommentaire(
                                        commentaires:
                                            etablissement.commentaires!,
                                      ),
                                      /* const SizedBox(
                                        height: 30,
                                      ) */
                                    ]),
                                  //OtherPlan(etablissement : etablissement)
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
      ]),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: padding),
        decoration: const BoxDecoration(
          color: backgroundColorWhite,
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(27, 224, 79, 103),
                offset: Offset(0, 1),
                blurRadius: 7)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: const Row(
          children: [
            IconButtonWidget(
              backgroundColor: favorisBackground,
              icon: 'assets/icons/share.svg',
              sizeIcon: iconSize,
              padding: 14,
              borderRadius: 15,
            ),
            SizedBox(
              width: 8,
            ),
            SizedBox(
              height: 54,
              child: ButtonWidget(
                label: 'Donner un avis',
              ),
            ),
            SizedBox(
              width: 8,
            ),
            SizedBox(
              height: 54,
              child: ButtonWidget(
                label: 'Signaler',
              ),
            )
          ],
        ),
      ),
    );
  }
}
