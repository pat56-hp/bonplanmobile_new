import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/constants/color.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: const Color.fromARGB(255, 233, 206, 206)
          .withOpacity(0.3), // Couleur de l'effet "splash"
      highlightColor: const Color.fromARGB(255, 189, 159, 159).withOpacity(0.2),
      child: Container(
        width: 38,
        height: 38,
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19), color: favorisBackground),
        child:
            SvgPicture.asset('assets/icons/heart.svg', color: appBarBackground),
      ),
    );
  }
}
