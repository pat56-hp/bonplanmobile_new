import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/category.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/utils/apiEndPoint.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  RxList<Etablissement> plansOfWeek = <Etablissement>[].obs;
  RxList<Etablissement> planByCategory = <Etablissement>[].obs;
  RxList<Category> categories = <Category>[].obs;

  // Récupération des données pour la page d'accueil
  Future<void> getHomeData() async {
    try {
      loading.value = true; // Début du chargement

      var response = await http.get(
        Uri.parse(ApiEndPoint.HomeData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        plansOfWeek.assignAll(
          (jsonResponse['planOfWeek'] as List)
              .map((data) => Etablissement.fromJson(data))
              .toList(),
        );

        categories.assignAll(
          (jsonResponse['categories'] as List)
              .map((data) => Category.fromJson(data))
              .toList(),
        );

        planByCategory.assignAll(
          (jsonResponse['planByCategory'] as List)
              .map((data) => Etablissement.fromJson(data))
              .toList(),
        );
      } else {
        print('Erreur serveur : ${jsonDecode(response.body)}');
      }
    } catch (e) {
      print('Erreur : ${e.toString()}');
    } finally {
      loading.value = false; // Fin du chargement, quelle que soit l'issue
    }
  }

  List<Etablissement> filterPlanByCategory(int categoryId) {
    return categoryId == 0
        ? planByCategory.toList()
        : planByCategory
            .where((plan) => plan.categoryId == categoryId)
            .toList();
  }
}
