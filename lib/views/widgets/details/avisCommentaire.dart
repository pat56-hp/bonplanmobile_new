import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/models/commentaire.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/views/widgets/IconButtonWidget.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:mobile/views/widgets/commentaireWidget.dart';

class AvisCommentaire extends StatelessWidget {
  const AvisCommentaire({super.key, required this.etablissement});

  final Etablissement etablissement;

  @override
  Widget build(BuildContext context) {
    List<Commentaire> commentaires = etablissement.commentaires!;

    void showModelCommentaires() => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              constraints: BoxConstraints(
                minHeight: 200,
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: padding, right: padding, bottom: padding),
              decoration: const BoxDecoration(
                  color: backgroundColorWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: profilBorder, width: 0.7),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 45,
                              width: 45,
                              decoration: ShapeDecoration(
                                shape: CircleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                              child: TextWidget(
                                  label: etablissement.note!
                                      .toDouble()
                                      .toString()),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  label: 'Commentaires',
                                  extra: const {
                                    'size': subtitle,
                                    'color': titleColor,
                                  },
                                ),
                                TextWidget(
                                    label:
                                        'Basé sur ${commentaires.length} avis')
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 28,
                          width: 28,
                          child: IconButtonWidget(
                              backgroundColor: profilBorder,
                              icon: 'assets/icons/cross.svg',
                              sizeIcon: 14,
                              padding: 0,
                              colorIcon: backgroundColorWhite,
                              pressFunction: () => Get.back()),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                        child: SingleChildScrollView(
                      child: Wrap(
                        runSpacing: 10,
                        children: commentaires
                            .map((commentaire) =>
                                CommentaireWidget(commentaire: commentaire))
                            .toList(),
                      ),
                    )),
                  )
                ],
              ),
            ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          label: 'Avis & commentaires',
          extra: {'color': titleColor},
        ),
        const SizedBox(
          height: 15,
        ),
        Wrap(
          runSpacing: 10,
          children: commentaires
              .take(2)
              .map((commentaire) => CommentaireWidget(commentaire: commentaire))
              .toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        if (commentaires.length > 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                splashColor: Colors.grey.withOpacity(0.3),
                highlightColor: Colors.grey.withOpacity(0.2),
                child: Row(
                  children: [
                    InkWell(
                      onTap: showModelCommentaires,
                      child: const TextWidget(
                        label: 'Voir plus',
                        extra: {
                          'size': textSize,
                          'color': textRed,
                          'fontWeight': FontWeight.bold,
                        },
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/icon-right.svg',
                      color: textRed,
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
