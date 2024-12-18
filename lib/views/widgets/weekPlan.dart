import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/homeController.dart';
import 'package:mobile/views/widgets/plans/largePlan.dart';

class WeekPlan extends StatelessWidget {
  const WeekPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return SizedBox(
      height: 300,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: homeController.plansOfWeek.length,
          scrollDirection: Axis.horizontal,
          padding:
              const EdgeInsets.symmetric(horizontal: padding, vertical: 10),
          itemBuilder: (context, index) {
            return index != -1
                ? Padding(
                    padding: EdgeInsets.only(
                        right: index < homeController.plansOfWeek.length
                            ? 20.0
                            : 0.0),
                    child: LargePlan(
                      etablissement: homeController.plansOfWeek[index],
                    ),
                  )
                : const SizedBox.shrink();
          }),
    );
  }
}
