import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/views/auth/widgets/BottomAuthLabel.dart';
import 'package:mobile/views/widgets/ButtonWidget.dart';
import 'package:mobile/views/widgets/InputWidget.dart';
import 'package:mobile/views/widgets/TextWidget.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          scrolledUnderElevation: 0,
          leading: Container(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              radius: 24,
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                'assets/icons/icon-left.svg',
                width: 22,
                height: 22,
              ),
            ),
          ),
          title: TextWidget(
            label: 'Mot de passe oublié',
            extra: {
              'color': titleColor,
              'size': title,
              'fontWeight': FontWeight.w400
            },
          ),
          centerTitle: true,
          //leading: Text('ok')
        ),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Center(
                child: TextWidget(
                  label:
                      'Veuillez renseigner votre adresse email pour obtenir le lien de réinitialisation',
                  extra: {
                    'size': label,
                  },
                ),
              ),
              const SizedBox(height: 30),
              const InputWidget(
                hintText: 'Adresse email',
                prefixIcon: 'assets/icons/envelope.svg',
                background: backgroundColorWhite,
              ),
              const SizedBox(height: 30),
              const SizedBox(
                height: 54,
                width: double.infinity,
                child: ButtonWidget(label: 'OBTENIR LE LIEN'),
              ),
              BottomAuthLabel(
                labelText: 'Déjà un compte ? ',
                clickLabel: 'Se connecter',
                route: () => Get.toNamed('/login'),
              )
            ],
          ),
        )));
  }
}
