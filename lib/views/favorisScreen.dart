import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/favorisController.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';
import 'package:mobile/views/widgets/plans/smallPlan.dart';

class FavorisScreen extends StatefulWidget {
  const FavorisScreen({super.key});

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  final Favoriscontroller _favorisController = Get.put(Favoriscontroller());

  void initState() {
    super.initState();
    _favorisController.getFavoris();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: Navigator.canPop(context)
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    radius: 24,
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      'assets/icons/icon-left.svg',
                      width: 22,
                      height: 22,
                    ),
                  ),
                )
              : null,
          title: const TextWidget(
            label: 'Mes favoris',
            extra: {'color': Colors.black, 'size': title},
          ),
        ),
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: Obx(() {
            return _favorisController.loading.value
                ? const LoadingCircularProgress(color: appBarBackground)
                : _favorisController.favoris.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/empty1.svg',
                            height: MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).size.height * 0.60),
                            width: MediaQuery.of(context).size.width -
                                (MediaQuery.of(context).size.width * 0.40),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextWidget(
                            label: 'Oups, vous n\'avez aucun favoris.',
                            extra: {
                              'size': subtitle,
                              'fontWeight': FontWeight.w500
                            },
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ..._favorisController.favoris
                                .map((favoris) => SmallPlan(plan: favoris))
                          ],
                        ),
                      );
          }),
        )));
  }
}
