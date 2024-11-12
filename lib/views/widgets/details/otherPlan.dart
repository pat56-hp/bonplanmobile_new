import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/controllers/exploreController.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/views/widgets/textWidget.dart';
import 'package:mobile/views/widgets/plans/smallPlan.dart';

class OtherPlan extends StatefulWidget {
  const OtherPlan({super.key, required this.etablissement});

  final Etablissement etablissement;

  @override
  State<OtherPlan> createState() => _OtherPlanState();
}

class _OtherPlanState extends State<OtherPlan> {
  @override
  Widget build(BuildContext context) {
    ExploreController exploreController = Get.put(ExploreController());
    List<Etablissement> etablissements =
        exploreController.otherPlan(widget.etablissement);

    return etablissements.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                label: 'Autre(s) plan(s)',
                extra: {
                  'color': titleColor,
                  'fontWeight': FontWeight.w500,
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Wrap(
                children: etablissements
                    .map((etablissement) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SmallPlan(
                            plan: etablissement,
                          ),
                        ))
                    .toList(),
              )
            ],
          )
        : const SizedBox.shrink();
  }
}
