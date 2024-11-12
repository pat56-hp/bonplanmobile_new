import 'package:get/get.dart';
import 'package:mobile/models/commodite.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/services/apiService.dart';
import 'package:mobile/utils/apiEndPoint.dart';

class CategoryController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  RxList<Commodite> commodites = <Commodite>[].obs;

  //Recuperation des categories
  Future getCategories() async {
    try {
      final response = await ApiService.get(ApiEndPoint.Categories);

      if (response.statusCode == 200) {
        final datas = response.data;

        categories.assignAll((datas['data'] as List)
            .map((category) => Category.fromJson(category)));
      }
    } catch (e) {
      print('Erreur server : ${e.toString()}');
    }
  }

  //Recupereation des commodites
  Future getCommodite() async {
    try {
      final response = await ApiService.get(ApiEndPoint.Commodites);

      if (response.statusCode == 200) {
        final datas = response.data;

        commodites.assignAll((datas['data'] as List)
            .map((commodite) => Commodite.fromJson(commodite)));
      }
    } catch (e) {
      print('Erreur serveur commodité : ${e.toString()}');
    }
  }
}
