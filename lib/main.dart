import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/controllers/authController.dart';
import 'package:mobile/controllers/categoryController.dart';
import 'package:mobile/controllers/commentaireController.dart';
import 'package:mobile/controllers/exploreController.dart';
import 'package:mobile/controllers/homeController.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/apiService.dart';

void main() async {
  await GetStorage.init(); // Initialisation du GetStorage
  ApiService.initializeInterceptors(); // Initialisation des intercepteurs API
  Get.put(AuthController());
  Get.put(HomeController());
  Get.put(ExploreController());
  Get.put(CategoryController());
  Get.put(CommentaireController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Les bons plans',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: true,
      initialRoute: '/splash_screen',
      getPages: Routes.appRoutes,
    );
  }
}