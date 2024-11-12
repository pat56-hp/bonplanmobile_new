import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/controllers/authController.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';

class SplashSreen extends StatefulWidget {
  const SplashSreen({super.key});

  @override
  State<SplashSreen> createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashSreen> {
  final AuthController _authController = Get.find<AuthController>();

  void initState() {
    super.initState();
    // Déclenche le démarrage de l'écran principal après 2 secondes
    Timer(Duration(seconds: 6), () {
      _authController.restoreSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Wrap avec Center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 70),
            LoadingCircularProgress(color: appBarBackground)
          ],
        ),
      ),
    );
  }
}
