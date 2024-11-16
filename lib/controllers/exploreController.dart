import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/services/apiService.dart';
import 'package:mobile/utils/apiEndPoint.dart';

class ExploreController extends GetxController {
  RxBool loading = false.obs;
  RxList<Etablissement> plans = <Etablissement>[].obs;
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Future getEtablissement({
    String? adresse,
    String? libelle,
    String? category,
    String? commodite,
  }) async {
    try {
      loading.value = true;

      _timer?.cancel();
      _timer = Timer(const Duration(milliseconds: 800), () async {
        // Base URL
        String url = ApiEndPoint.ExplorePlan;

        // Créer une map pour les paramètres
        Map<String, String> queryParams = {};

        // Ajouter chaque paramètre seulement s'il n'est pas null
        if (adresse != null) {
          queryParams['adresse'] = adresse;
        }

        if (libelle != null) {
          queryParams['libelle'] = libelle;
        }

        if (category != null) {
          queryParams['category'] = category;
        }

        if (commodite != null) {
          queryParams['commodite'] = commodite;
        }

        // Faire la requête HTTP avec les paramètres valides seulement
        final response = await ApiService.get(url, query: queryParams);

        if (response.statusCode == 200) {
          final jsonResponse = response.data;
          plans.assignAll((jsonResponse['data'] as List)
              .map((data) => Etablissement.fromJson(data))
              .toList());
        } else {
          print('Erreur serveur : ${jsonDecode(response.body)}');
        }

        loading.value = false;
      });
    } catch (e) {
      print('Erreur serveur : ${e.toString()}');
      loading.value = false;
    }
  }

  List<Etablissement> filterPlanByCategory(int categoryId) {
    return categoryId == 0
        ? plans.toList()
        : plans.where((plan) => plan.categoryId == categoryId).toList();
  }

  List<Etablissement> otherPlan(Etablissement etablissement) {
    return plans
        .where((plan) =>
            plan.categoryId == etablissement.categoryId &&
            plan.id != etablissement.id)
        .take(4)
        .toList();
  }

  void updateEtablissement(Etablissement etablissement) {
    final index = plans.indexWhere((e) => e.id == etablissement.id);

    if (index != -1) {
      plans[index] = etablissement;
      plans.refresh();
    }
  }
}
