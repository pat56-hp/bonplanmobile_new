import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/authController.dart';
import 'package:mobile/views/widgets/DrawerItem.dart';
import 'package:mobile/views/widgets/textWidget.dart';
import 'package:mobile/views/widgets/userImage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/cross.svg',
                    height: iconSize,
                    width: iconSize,
                    color: iconColor,
                  ))
            ],
          ),
          Column(
            children: [
              const UserImage(
                height: 98,
                width: 98,
                borderColor: buttonDefaultColor,
                borderRadius: 49,
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                label:
                    '${_authController.user.value!.name.toString()} ${_authController.user.value!.lastname.toString()}',
                extra: const {
                  'color': textColor,
                  'fontWeight': FontWeight.bold,
                  'size': title
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextWidget(
                label: _authController.user.value!.email.toString(),
                extra: const {'color': textColor},
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 155,
                height: 1.0,
                color: border,
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                icon: 'assets/icons/user.svg',
                label: 'Mon profil',
                onPress: () => Navigator.pushNamed(context, '/profil'),
              ),
              DrawerItem(
                icon: 'assets/icons/heart.svg',
                label: 'Mes favoris',
                onPress: () => Navigator.pushNamed(context, '/favoris'),
              ),
              const DrawerItem(
                  icon: 'assets/icons/calendar.svg', label: 'Evènements'),
              const DrawerItem(
                  icon: 'assets/icons/envelope.svg', label: 'Nous contacter'),
              const DrawerItem(
                  icon: 'assets/icons/settings.svg',
                  label: 'Politiques de confidentialités'),
              const DrawerItem(
                  icon: 'assets/icons/config.svg', label: 'Configurations'),
              DrawerItem(
                icon: 'assets/icons/exit.svg',
                label: 'Déconnexion',
                onPress: () => _authController.logout(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
