import 'dart:convert';
import 'package:get/get.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/services/apiService.dart';
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

      final response = await ApiService.get(ApiEndPoint.HomeData);

      if (response.statusCode == 200) {
        final jsonResponse = response.data;

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

  void updateEtablissement(Etablissement etablissement) {
    //final index = plansOfWeek.indexWhere((e) => e.id == etablissement.id);
    /* final indexByCategory =
        planByCategory.indexWhere((e) => e.id == etablissement.id); */

    var etablissementExist =
        plansOfWeek.where((e) => e.id == etablissement.id).firstOrNull;

    var etablissementCategoryExist =
        planByCategory.where((e) => e.id == etablissement.id).firstOrNull;

    if (etablissementExist != null) {
      etablissementExist = etablissement;
      plansOfWeek.refresh();
    }

    if (etablissementCategoryExist != null) {
      etablissementCategoryExist = etablissement;
      planByCategory.refresh();
    }

    /* if (index != -1) {
      plansOfWeek[index] = etablissement;
      plansOfWeek.refresh();
    }

    if (indexByCategory != -1) {
      plansOfWeek[indexByCategory] = etablissement;
      plansOfWeek.refresh();
    } */
  }
}
