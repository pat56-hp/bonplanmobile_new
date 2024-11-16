import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/models/commentaire.dart';
import 'package:mobile/views/widgets/Stars.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:mobile/views/widgets/UserImage.dart';
import 'package:mobile/views/widgets/textWidgetTroncate.dart';

class AvisCommentaire extends StatelessWidget {
  const AvisCommentaire({super.key, required this.commentaires});

  final List<Commentaire> commentaires;

  @override
  Widget build(BuildContext context) {
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
              .map((commentaire) => Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: backgroundColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserImage(
                        height: 44,
                        width: 44,
                        borderRadius: 22,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    label:
                                        '${commentaire.client?.name.toString()} ${commentaire.client?.lastname.toString()}',
                                    extra: const {
                                      'fontWeight': FontWeight.w500,
                                    },
                                  ),
                                  TextWidget(
                                    label: commentaire.date.toString(),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Stars(
                                size: 14,
                                note: commentaire.note.toDouble(),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextWidgetTroncate(
                                text: commentaire.commentaire.toString(),
                                maxLines: 140,
                              )
                            ]),
                      )
                    ],
                  )))
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
                    const TextWidget(
                      label: 'Voir plus',
                      extra: {
                        'size': textSize,
                        'color': textRed,
                        'fontWeight': FontWeight.bold,
                      },
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
