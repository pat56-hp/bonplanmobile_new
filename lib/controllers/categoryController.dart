import 'package:get/get.dart';
import 'package:mobile/models/commodite.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/services/apiService.dart';
import 'package:mobile/utils/apiEndPoint.dart';

class CategoryController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  RxList<Commodite> commodites = <Commodite>[].obs;
  RxBool loading = false.obs;

  //Recuperation des categories
  Future getCategories() async {
    loading.value = true;

    try {
      final response = await ApiService.get(ApiEndPoint.Categories);

      if (response.statusCode == 200) {
        final datas = response.data;

        categories.assignAll((datas['data'] as List)
            .map((category) => Category.fromJson(category)));
      }

      loading.value = false;
    } catch (e) {
      print('Erreur server : ${e.toString()}');
      loading.value = false;
    }
  }

  //Recupereation des commodites
  Future getCommodite() async {
    loading.value = true;

    try {
      final response = await ApiService.get(ApiEndPoint.Commodites);

      if (response.statusCode == 200) {
        final datas = response.data;

        commodites.assignAll((datas['data'] as List)
            .map((commodite) => Commodite.fromJson(commodite)));
      }
      loading.value = false;
    } catch (e) {
      print('Erreur serveur commodité : ${e.toString()}');
      loading.value = false;
    }
  }

  String getCategoryLibelle(int id) {
    return categories
        .firstWhere((category) => category.id == id)
        .libelle
        .toString();
  }

  String getCommoditeLibelle(int id) {
    return commodites
        .firstWhere((commodite) => commodite.id == id)
        .libelle
        .toString();
  }
}
