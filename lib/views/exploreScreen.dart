import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/exploreController.dart';
import 'package:mobile/controllers/homeController.dart';
import 'package:mobile/views/widgets/categoryButton.dart';
import 'package:mobile/views/widgets/emptyData.dart';
import 'package:mobile/views/widgets/iconButtonWidget.dart';
import 'package:mobile/views/widgets/inputWidget.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';
import 'package:mobile/views/widgets/textWidget.dart';
import 'package:mobile/views/widgets/plans/smallPlan.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, this.searchData});

  final Map? searchData;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedCategory = 0;
  final HomeController _homeController = Get.find<HomeController>();
  final ExploreController _exploreController = Get.find<ExploreController>();
  final TextEditingController _controller = TextEditingController();
  final arguments = Get.arguments;
  String _previousValue = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    //Renvoie les etablissements sans filtre
    _fetchData();

    // Écoute les changements de texte pour la recherche
    _controller.addListener(() {
      if (_controller.text != _previousValue && _controller.text != '') {
        _previousValue = _controller.text;

        // Réinitialise le timer à chaque changement
        _fetchDataByTitle(_controller.text);
      }
    });
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    _exploreController
        .getEtablissement(
      libelle: widget.searchData?['libelle'],
      adresse: widget.searchData?['adresse'],
      category: widget.searchData?['category'],
      commodite: widget.searchData?['commodite'],
    )
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _fetchDataByTitle(String query) {
    setState(() {
      _isLoading = true;
    });
    _exploreController
        .getEtablissement(
      libelle: query,
    )
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void selectedCategory(int categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
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
            label: 'Explorer',
            extra: {
              'fontWeight': FontWeight.w500,
              'size': title,
              'color': Colors.black
            },
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: padding, vertical: padding),
              child: TextWidget(
                label:
                    'Retouvez les bons plans de divertissement prêt de chez vous',
                extra: {
                  'size': subtitle,
                  'fontWeight': FontWeight.w500,
                  'textAlign': TextAlign.start
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InputWidget(
                      controller: _controller,
                      hintText: 'Retrouver un établissement',
                      prefixIcon: 'assets/icons/search.svg',
                      background: backgroundColorWhite,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButtonWidget(
                      backgroundColor: backgroundColorWhite,
                      icon: 'assets/icons/filter.svg',
                      pressFunction: () => Get.offNamed('/search')),
                ],
              ),
            ),
            const SizedBox(height: padding),
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
                  ..._homeController.categories.map((plan) => GestureDetector(
                        onTap: () => selectedCategory(plan.id!),
                        child: CategoryButton(
                          categoryLabel: plan.libelle!,
                          selectedCategory: _selectedCategory,
                          index: plan.id!,
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: padding),
            Expanded(
                child: _isLoading == true
                    ? const LoadingCircularProgress(
                        color: appBarBackground,
                      )
                    : Obx(() {
                        return ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: padding),
                              child: Column(
                                children: _exploreController
                                        .filterPlanByCategory(_selectedCategory)
                                        .isNotEmpty
                                    ? _exploreController
                                        .filterPlanByCategory(_selectedCategory)
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
                        );
                      }))
          ],
        )),
      ),
    );
  }
}
