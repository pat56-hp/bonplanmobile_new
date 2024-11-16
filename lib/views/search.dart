import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/categoryController.dart';
import 'package:mobile/views/exploreScreen.dart';
import 'package:mobile/views/widgets/buttonWidget.dart';
import 'package:mobile/views/widgets/inputWidget.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';
import 'package:mobile/views/widgets/textWidget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class CategorySelected {
  int? id;

  CategorySelected({this.id});
}

class CommoditeSelected {
  int? id;

  CommoditeSelected({this.id});
}

class _SearchState extends State<Search> {
  final CategoryController _categoryController = Get.find<CategoryController>();
  final _nameController = TextEditingController();
  final _adresseController = TextEditingController();
  List<CategorySelected> _selectedCategory = [];
  List<CommoditeSelected> _selectedCommodite = [];

  @override
  void initState() {
    _categoryController.getCategories();
    _categoryController.getCommodite();
    super.initState();
  }

  bool _verifiyCategorySelected(int categoryId) {
    return _selectedCategory.any((category) => category.id == categoryId);
  }

  void _addSelectedCategory(int categoryId) {
    setState(() {
      if (!_verifiyCategorySelected(categoryId)) {
        _selectedCategory.add(CategorySelected(id: categoryId));
      } else {
        _selectedCategory.removeWhere((category) => category.id == categoryId);
      }
    });
  }

  bool _verifiyCommoditeSelected(int commoditeId) {
    return _selectedCommodite.any((commodite) => commodite.id == commoditeId);
  }

  void _addSelectedCommodite(int commoditeId) {
    setState(() {
      if (!_verifiyCommoditeSelected(commoditeId)) {
        _selectedCommodite.add(CommoditeSelected(id: commoditeId));
      } else {
        _selectedCommodite
            .removeWhere((commodite) => commodite.id == commoditeId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void filterSendData() {
      List categoryIds =
          _selectedCategory.map((category) => category.id).toList();
      List commoditeIds =
          _selectedCommodite.map((commodite) => commodite.id).toList();

      Map data = {
        'adresse': _adresseController.text,
        'libelle': _nameController.text,
        'category': categoryIds.join(','),
        'commodite': commoditeIds.join(','),
      };

      Get.off(() => ExploreScreen(searchData: data));
    }

    void showBottomSheetbarCategory() {
      Get.bottomSheet(
        StatefulBuilder(// Ajout du StatefulBuilder
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: padding, vertical: padding),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 4,
                      width: 70,
                      color: profilBorder,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputWidget(
                      hintText: 'Retrouver une catégorie',
                      prefixIcon: 'assets/icons/search.svg',
                      hintTextColor: placeholderColor,
                      background: backgroundColorWhite,
                      sizeIcon: 18.0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.31,
                      child: ListView.builder(
                          itemCount: _categoryController.categories.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: appBarBackground,
                              checkColor: backgroundColorWhite,
                              title: TextWidget(
                                label: _categoryController
                                    .categories[index].libelle!,
                                extra: const {'textAlign': TextAlign.start},
                              ),
                              value: _verifiyCategorySelected(
                                  _categoryController.categories[index].id!),
                              onChanged: (bool? value) {
                                setModalState(() {
                                  // Utilisation de setModalState
                                  _addSelectedCategory(_categoryController
                                      .categories[index].id!);
                                });
                              },
                            );
                          }),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: border))),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ButtonWidget(
                      label: 'Fermer',
                      backgroundColor: borderActive,
                      onPress: Get.back,
                    ),
                  ),
                )
              ],
            ),
          );
        }),
        backgroundColor: backgroundColorWhite,
        isDismissible: true,
      );
    }

    void showBottomSheetbarCommodite() {
      Get.bottomSheet(
        StatefulBuilder(// Ajout du StatefulBuilder
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: padding, vertical: padding),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 4,
                      width: 70,
                      color: profilBorder,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputWidget(
                      hintText: 'Retrouver une commodité',
                      prefixIcon: 'assets/icons/search.svg',
                      hintTextColor: placeholderColor,
                      background: backgroundColorWhite,
                      sizeIcon: 18.0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.31,
                      child: ListView.builder(
                          itemCount: _categoryController.commodites.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: appBarBackground,
                              checkColor: backgroundColorWhite,
                              title: TextWidget(
                                label: _categoryController
                                    .commodites[index].libelle!,
                                extra: const {'textAlign': TextAlign.start},
                              ),
                              value: _verifiyCommoditeSelected(
                                  _categoryController.commodites[index].id!),
                              onChanged: (bool? value) {
                                setModalState(() {
                                  // Utilisation de setModalState
                                  _addSelectedCommodite(_categoryController
                                      .commodites[index].id!);
                                });
                              },
                            );
                          }),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: border))),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ButtonWidget(
                      label: 'Fermer',
                      backgroundColor: borderActive,
                      onPress: Get.back,
                    ),
                  ),
                )
              ],
            ),
          );
        }),
        backgroundColor: backgroundColorWhite,
        isDismissible: true,
      );
    }

    return GestureDetector(
      onTap: () {},
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
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
              label: 'Recherche avancée',
              extra: {
                'fontWeight': FontWeight.w500,
                'size': title,
                'color': Colors.black
              },
            ),
          ),
          body: Obx(() {
            return _categoryController.loading.value
                ? LoadingCircularProgress(
                    color: appBarBackground,
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputWidget(
                            controller: _nameController,
                            hintText: 'Nom de l\'établissement',
                            suffixIcon: 'assets/icons/tags.svg',
                            hintTextColor: placeholderColor,
                            background: backgroundColorWhite,
                            sizeIcon: 20.0,
                          ),
                          SizedBox(
                            height: padding,
                          ),
                          InputWidget(
                            controller: _adresseController,
                            hintText: 'Adresse de l\'établissement',
                            suffixIcon: 'assets/icons/tags.svg',
                            hintTextColor: placeholderColor,
                            background: backgroundColorWhite,
                            sizeIcon: 20.0,
                          ),
                          SizedBox(
                            height: padding,
                          ),
                          InputWidget(
                            hintText: 'Sélectionnez des catégories',
                            hintTextColor: placeholderColor,
                            background: backgroundColorWhite,
                            suffixIcon: 'assets/icons/bookmark.svg',
                            sizeIcon: 20.0,
                            readOnly: true,
                            clickFunction: () => showBottomSheetbarCategory(),
                          ),
                          if (_selectedCategory.isNotEmpty)
                            Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    ..._selectedCategory.map((category) =>
                                        InkWell(
                                          onTap: () => _addSelectedCategory(
                                              category.id!),
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: appBarBackground,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(10)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextWidget(
                                                  label: _categoryController
                                                      .getCategoryLibelle(
                                                          category.id!),
                                                  extra: const {
                                                    'color': textWhite
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/icons/cross.svg',
                                                  color: textWhite,
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          SizedBox(
                            height: padding,
                          ),
                          InputWidget(
                            hintText: 'Sélectionnez des commodités',
                            hintTextColor: placeholderColor,
                            background: backgroundColorWhite,
                            suffixIcon: 'assets/icons/bookmark.svg',
                            sizeIcon: 20.0,
                            readOnly: true,
                            clickFunction: () => showBottomSheetbarCommodite(),
                          ),
                          if (_selectedCommodite.isNotEmpty)
                            Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    ..._selectedCommodite.map((commodite) =>
                                        InkWell(
                                          onTap: () => _addSelectedCommodite(
                                              commodite.id!),
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: appBarBackground,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(10)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextWidget(
                                                  label: _categoryController
                                                      .getCommoditeLibelle(
                                                          commodite.id!),
                                                  extra: const {
                                                    'color': textWhite
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/icons/cross.svg',
                                                  color: textWhite,
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
          }),
          persistentFooterButtons: [
            SizedBox(
              height: 50,
              child: ButtonWidget(
                onPress: filterSendData,
                iconWidget: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: 20,
                      height: 20,
                      color: backgroundColorWhite,
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                label: 'FILTRER',
              ),
            )
          ]),
    );
  }
}
