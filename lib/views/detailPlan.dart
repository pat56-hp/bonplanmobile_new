import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/commentaireController.dart';
import 'package:mobile/models/commentaire.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/utils/apiEndPoint.dart';
import 'package:mobile/utils/helper.dart';
import 'package:mobile/views/widgets/ButtonWidget.dart';
import 'package:mobile/views/widgets/IconButtonWidget.dart';
import 'package:mobile/views/widgets/ImageWidget.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:mobile/views/widgets/TextWidgetTroncate.dart';
import 'package:mobile/views/widgets/inputWidget.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';
import 'package:mobile/views/widgets/stars.dart';
import 'package:mobile/views/widgets/wishlistButton.dart';
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
  late Etablissement etablissement = Get.arguments;
  final TextEditingController _commentaireInputController =
      TextEditingController();
  final CommentaireController _commentaireController =
      Get.put(CommentaireController());
  int _noteSelected = 0;

  @override
  Widget build(BuildContext context) {
    var document = parse(etablissement.description.toString());
    String description = document.body?.text ?? '';

    Future storeCommentaire() async {
      if (_commentaireInputController.text == '' || _noteSelected == 0) {
        showDialogWidget('Erreur',
            'Veuillez renseigner un commentaire et donner votre avis svp.');
        return;
      }

      final bool response = await _commentaireController.storeCommentaire(
        commentaires: _commentaireInputController.text,
        note: _noteSelected,
        etablissementId: etablissement.id!,
      );

      if (response) {
        _commentaireInputController.clear();
        _noteSelected = 0;
        setState(() {
          etablissement = _commentaireController.etablissement.value!;
        });

        Get.back();
        showSnackBarWidget(
            type: 'success', content: 'Votre commentaire a été ajouté');
      } else {
        showSnackBarWidget(
            type: 'error', content: 'Oups, une erreur s\'est produite.');
      }
    }

    void showModalComment() {
      Get.bottomSheet(
        StatefulBuilder(// Ajout du StatefulBuilder
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            constraints: BoxConstraints(
              minHeight: 200,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(padding),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextWidget(label: 'Donner votre avis', extra: const {
                  'fontWeight': FontWeight.bold,
                  'size': title
                }),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Scrollbar(
                    thickness: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFc5e7fc),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/signal.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextWidget(
                                    label:
                                        'Votre avis permet aux autres utilisateurs de faire leur choix',
                                    extra: const {'textAlign': TextAlign.start},
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(label: 'Commentaire', extra: const {
                                'textAlign': TextAlign.start,
                                'fontWeight': FontWeight.w500
                              }),
                            ],
                          ),
                          InputWidget(
                            controller: _commentaireInputController,
                            hintText: 'Commentaire',
                            prefixIcon: 'assets/icons/comment.svg',
                          ),
                          const SizedBox(
                            height: padding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                  label: 'Ajouter une note',
                                  extra: const {
                                    'textAlign': TextAlign.start,
                                    'fontWeight': FontWeight.w500
                                  }),
                            ],
                          ),
                          Flexible(
                              child: Column(
                            children: [
                              ...List.generate(5, (index) {
                                return RadioListTile(
                                  groupValue: _noteSelected,
                                  overlayColor:
                                      WidgetStateProperty.all(profilBorder),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: appBarBackground,
                                  title: Stars(
                                      note: (5 - index).toDouble(), size: 20),
                                  value: 5 - index,
                                  onChanged: (note) {
                                    setModalState(() {
                                      _noteSelected = 5 - index;
                                    });
                                  },
                                );
                              })
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: border))),
                  child: Obx(() {
                    return _commentaireController.loading.value
                        ? const LoadingCircularProgress(
                            color: appBarBackground,
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ButtonWidget(
                                    label: 'Valider',
                                    onPress: storeCommentaire,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ButtonWidget(
                                    label: 'Fermer',
                                    backgroundColor: borderActive,
                                    onPress: Get.back,
                                  ),
                                ),
                              ),
                            ],
                          );
                  }),
                )
              ],
            ),
          );
        }),
        backgroundColor: backgroundColorWhite,
        isDismissible: true,
        isScrollControlled: true,
      );
    }

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
              WishlistButton(etablissement: etablissement)
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
                    padding: const EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        /* Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          height: 4,
                          width: 70,
                          color: profilBorder,
                        ), */
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
                                        etablissement: etablissement,
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
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 54,
                child: ButtonWidget(
                    label: 'Donner une note', onPress: showModalComment),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            IconButtonWidget(
              backgroundColor: favorisBackground,
              icon: 'assets/icons/share.svg',
              sizeIcon: iconSize,
              padding: 14,
              borderRadius: 15,
            ),
          ],
        ),
      ),
    );
  }
}
