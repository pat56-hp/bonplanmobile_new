import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/controllers/exploreController.dart';
import 'package:mobile/controllers/favorisController.dart';
import 'package:mobile/controllers/homeController.dart';
import 'package:mobile/models/etablissement.dart';

class WishlistButton extends StatefulWidget {
  const WishlistButton({super.key, required this.etablissement});

  final Etablissement etablissement;

  @override
  State<WishlistButton> createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<WishlistButton> {
  final Favoriscontroller _favorisController = Get.put(Favoriscontroller());
  final HomeController _homeController = Get.find<HomeController>();
  final ExploreController _exploreController = Get.find<ExploreController>();

  final String heartIcon = 'assets/icons/heart.svg';
  final String heartFavoriteIcon = 'assets/icons/heart-active.svg';
  late bool isFavorite = widget.etablissement.favoris!;

  Future _handleAddOrRemoveFavorite() async {
    final response =
        await _favorisController.handleAddOrRemove(widget.etablissement);

    setState(() {
      if (response == true) {
        isFavorite = true;
      } else if (response == false) {
        isFavorite = false;
      }
      _homeController.updateEtablissement(widget.etablissement);
      _exploreController.updateEtablissement(widget.etablissement);
      _favorisController.updateEtablissementFavoris(widget.etablissement);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('Favoris ${widget.etablissement.id} : ${widget.etablissement.favoris}');
    return InkWell(
      onTap: _handleAddOrRemoveFavorite,
      splashColor: const Color.fromARGB(255, 233, 206, 206)
          .withOpacity(0.3), // Couleur de l'effet "splash"
      highlightColor: const Color.fromARGB(255, 189, 159, 159).withOpacity(0.2),
      child: Container(
        width: 38,
        height: 38,
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19), color: favorisBackground),
        child: SvgPicture.asset(isFavorite ? heartFavoriteIcon : heartIcon,
            color: appBarBackground),
      ),
    );
  }
}
