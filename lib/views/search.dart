import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/categoryController.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/models/commodite.dart';
import 'package:mobile/views/widgets/buttonWidget.dart';
import 'package:mobile/views/widgets/inputWidget.dart';
import 'package:mobile/views/widgets/textWidget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final CategoryController _categoryController = Get.find<CategoryController>();
  List<Category?> _selectedCategories = [];
  List<Commodite?> _selectedCommodites = [];
  int _selectedCategoriesLenght = 0;
  int _selectedCommoditesLenght = 0;

  @override
  void initState() {
    _categoryController.getCategories();
    _categoryController.getCommodite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesItems = _categoryController.categories
        .map((category) =>
            MultiSelectItem<Category>(category, category.libelle!))
        .toList();

    final commoditesItems = _categoryController.commodites
        .map((commodite) =>
            MultiSelectItem<Commodite>(commodite, commodite.libelle!))
        .toList();

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
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputWidget(
                    hintText: 'Nom de l\'établissement',
                    prefixIcon: 'assets/icons/search.svg',
                    hintTextColor: placeholderColor,
                    background: backgroundColorWhite,
                  ),
                  SizedBox(
                    height: padding,
                  ),
                  InputWidget(
                    hintText: 'Adresse de l\'établissement',
                    prefixIcon: 'assets/icons/search.svg',
                    hintTextColor: placeholderColor,
                    background: backgroundColorWhite,
                  ),
                  SizedBox(
                    height: padding,
                  ),
                  Column(
                    children: <Widget>[
                      MultiSelectBottomSheetField(
                        backgroundColor: backgroundColorWhite,
                        selectedColor: activeNavigationBarItem,
                        initialChildSize: 0.4,
                        searchable: true,
                        isDismissible: false,
                        listType: MultiSelectListType.LIST,
                        title: TextWidget(
                          label: 'Catégories',
                          extra: const {'size': 15.0},
                        ),
                        searchHint: 'Rechercher une catégorie',
                        buttonText: Text(
                          "Sélectionnez des catégories",
                          style: TextStyle(
                              fontSize: 15.0, color: textColor, height: 2.2),
                        ),
                        checkColor: appBarBackground,
                        items: categoriesItems,
                        confirmText: Text('Valider'),
                        cancelText: Text('Annuler'),
                        separateSelectedItems: false,
                        decoration: BoxDecoration(
                            color: backgroundColorWhite,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: profilBorder)),
                        onConfirm: (values) {
                          _selectedCategories = values.cast<Category?>();
                          setState(() {
                            _selectedCategoriesLenght =
                                _selectedCategories.length;
                          });
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              _selectedCategories.remove(value);
                              _selectedCategoriesLenght =
                                  _selectedCategories.length;
                            });
                          },
                        ),
                      ),
                      _selectedCategoriesLenght == 0
                          ? Container(
                              padding: EdgeInsets.only(top: 2, left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Aucune catégorie sélectionnée",
                                style: TextStyle(color: Colors.black54),
                              ))
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: padding,
                  ),
                  Column(
                    children: <Widget>[
                      MultiSelectBottomSheetField(
                        backgroundColor: backgroundColorWhite,
                        selectedColor: activeNavigationBarItem,
                        initialChildSize: 0.4,
                        searchable: true,
                        listType: MultiSelectListType.LIST,
                        title: TextWidget(
                          label: 'Commodités',
                          extra: const {'size': 15.0},
                        ),
                        searchHint: 'Rechercher une commodité',
                        buttonText: Text(
                          "Sélectionnez des commodités",
                          style: TextStyle(
                              fontSize: 15.0, color: textColor, height: 2.2),
                        ),
                        isDismissible: false,
                        checkColor: appBarBackground,
                        items: commoditesItems,
                        confirmText: Text('Valider'),
                        cancelText: Text('Annuler'),
                        separateSelectedItems: false,
                        decoration: BoxDecoration(
                            color: backgroundColorWhite,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: profilBorder)),
                        onConfirm: (values) {
                          _selectedCommodites = values.cast<Commodite?>();
                          setState(() {
                            _selectedCommoditesLenght =
                                _selectedCommodites.length;
                          });
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              _selectedCommodites.remove(value);
                              _selectedCommoditesLenght =
                                  _selectedCommodites.length;
                            });
                          },
                        ),
                      ),
                      _selectedCommoditesLenght == 0
                          ? Container(
                              padding: EdgeInsets.only(top: 2, left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Aucune commodité sélectionnée",
                                style: TextStyle(color: Colors.black54),
                              ))
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          persistentFooterButtons: [
            SizedBox(
              height: 50,
              child: ButtonWidget(
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
