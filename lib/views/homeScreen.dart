import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/authController.dart';
import 'package:mobile/controllers/homeController.dart';
import 'package:mobile/views/drawerWidget.dart';
import 'package:mobile/views/widgets/emptyData.dart';
import 'package:mobile/views/widgets/iconButtonWidget.dart';
import 'package:mobile/views/widgets/inputWidget.dart';
import 'package:mobile/views/widgets/textWidget.dart';
import 'package:mobile/views/widgets/userImage.dart';
import 'package:mobile/views/widgets/categoryButton.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';
import 'package:mobile/views/widgets/plans/smallPlan.dart';
import 'package:mobile/views/widgets/weekPlan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.find<HomeController>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _homeController.getHomeData();
  }

  late int _selectedCategory = 0;

  void selectedCategory(int categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: appBarBackground,
        toolbarHeight: 70.0,
        title: Row(
          children: [
            const UserImage(height: 56, width: 56),
            const SizedBox(
              width: 13,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                    label: 'Bienvenue', extra: {'color': textWhite}),
                TextWidget(
                  label:
                      '${_authController.user.value?.name.toString()} ${_authController.user.value?.lastname.toString()}',
                  extra: const {
                    'color': textWhite,
                    'fontWeight': FontWeight.bold
                  },
                )
              ],
            ),
          ],
        ),
        actions: [
          Builder(builder: (context) {
            return Container(
                margin: const EdgeInsets.only(right: 15.0),
                child: IconButtonWidget(
                  backgroundColor: drawerButton,
                  icon: 'assets/icons/icon-menu.svg',
                  pressFunction: () => Scaffold.of(context).openEndDrawer(),
                  padding: 8.0,
                ));
          })
        ],
      ),
      endDrawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: drawerBackground,
        width: MediaQuery.of(context).size.width - 100,
        child: const SingleChildScrollView(
          child: DrawerWidget(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  padding: const EdgeInsets.only(
                    left: padding,
                    right: padding,
                    bottom: 80,
                  ),
                  decoration: const BoxDecoration(
                    color: appBarBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      /** Input de recherche **/
                      InputWidget(
                        readOnly: true,
                        clickFunction: () => Get.toNamed('/search'),
                        hintText: 'Retrouver un établissement',
                        prefixIcon: 'assets/icons/search.svg',
                        hintTextColor: placeholderColor,
                      ),
                      SizedBox(height: 30),
                      /** Titre et bouton voir plus **/
                    ],
                  ),
                ),
                Obx(() {
                  return _homeController.loading.value
                      ? Container(
                          margin: const EdgeInsets.only(top: 120),
                          child: const LoadingCircularProgress(),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 100),
                          child: Column(
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: padding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      label: 'Les plans de la semaine',
                                      extra: {
                                        'size': subtitle,
                                        'color': textWhite,
                                        'fontWeight': FontWeight.bold,
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const WeekPlan(),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: padding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      child: TextWidget(
                                        label:
                                            'Les établissements par catégorie',
                                        extra: {
                                          'size': subtitle,
                                          'color': titleColor,
                                          'fontWeight': FontWeight.bold,
                                          'textAlign': TextAlign.start,
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => Get.toNamed('/explore'),
                                      splashColor: Colors.grey.withOpacity(0.3),
                                      highlightColor:
                                          Colors.grey.withOpacity(0.2),
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
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 75,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: padding, vertical: 10),
                                  children: [
                                    GestureDetector(
                                      onTap: () => selectedCategory(0),
                                      child: CategoryButton(
                                        categoryLabel: 'Tous',
                                        selectedCategory: _selectedCategory,
                                        index: 0,
                                      ),
                                    ),
                                    ..._homeController.categories
                                        .map((plan) => GestureDetector(
                                              onTap: () =>
                                                  selectedCategory(plan.id!),
                                              child: CategoryButton(
                                                categoryLabel: plan.libelle!,
                                                selectedCategory:
                                                    _selectedCategory,
                                                index: plan.id!,
                                              ),
                                            ))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: padding),
                                child: Column(
                                  children: _homeController
                                          .filterPlanByCategory(
                                              _selectedCategory)
                                          .isNotEmpty
                                      ? _homeController
                                          .filterPlanByCategory(
                                              _selectedCategory)
                                          .map((plan) => SmallPlan(plan: plan))
                                          .toList()
                                      : [
                                          const EmptyData(
                                              label:
                                                  'Aucun établissement disponible')
                                        ],
                                ),
                              ),
                            ],
                          ),
                        );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
