import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/views/widgets/TextWidget.dart';

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const TextWidget(
            label: 'Mes favoris',
            extra: {'color': Colors.black, 'size': title},
          ),
        ),
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: Column(
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
                extra: {'size': subtitle, 'fontWeight': FontWeight.w500},
              ),
            ],
          ),
        )));
  }
}
