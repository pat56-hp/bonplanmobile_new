import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/models/commentaire.dart';
import 'package:mobile/views/widgets/TextWidgetTroncate.dart';
import 'package:mobile/views/widgets/stars.dart';
import 'package:mobile/views/widgets/textWidget.dart';
import 'package:mobile/views/widgets/userImage.dart';

class CommentaireWidget extends StatelessWidget {
  const CommentaireWidget({super.key, required this.commentaire});
  final Commentaire commentaire;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: backgroundColor),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ));
  }
}
