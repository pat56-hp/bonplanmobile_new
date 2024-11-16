import 'package:get/get.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/services/apiService.dart';
import 'package:mobile/utils/apiEndPoint.dart';
import 'package:mobile/utils/helper.dart';

class Favoriscontroller extends GetxController {
  RxList<Etablissement> favoris = <Etablissement>[].obs;
  RxBool loading = false.obs;

  Future handleAddOrRemove(Etablissement etablissement) async {
    try {
      final response = await ApiService.post(
          '${ApiEndPoint.AddOrRemoveFavoris}/${etablissement.id}', {});

      if (response.statusCode == 200) {
        final bool favorisStatus = response.data['favoris'];

        if (favorisStatus) {
          showSnackBarWidget(
              type: 'success', content: 'Etablissement ajouté aux favoris');
        } else {
          showSnackBarWidget(
              type: 'success', content: 'Etablissement supprimé des favoris');
        }

        etablissement.favoris = favorisStatus;
        return favorisStatus;
      }
    } catch (e) {
      print(
          'Erreur lors de l\'ajout ou la suppression de favoris : ${e.toString()}');
    }
  }

  Future getFavoris() async {
    loading.value = true;

    try {
      final response = await ApiService.get(ApiEndPoint.Favoris);

      if (response.statusCode == 200) {
        final data = response.data['data'];
        favoris.assignAll(
            (data as List).map((favoris) => Etablissement.fromJson(favoris)));
        loading.value = false;
      }
    } catch (e) {
      print('Http error : ${e.toString()}');
      loading.value = false;
    }
  }

  void updateEtablissementFavoris(Etablissement etablissement) {
    favoris.removeWhere(
        (e) => e.id == etablissement.id && e.favoris == etablissement.favoris);
    favoris.refresh();
  }
}
