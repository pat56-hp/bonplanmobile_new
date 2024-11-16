import 'package:get/get.dart';
import 'package:mobile/models/commentaire.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/services/apiService.dart';
import 'package:mobile/utils/apiEndPoint.dart';

class CommentaireController extends GetxController {
  final RxBool loading = false.obs;
  late final Rxn<Commentaire> commentaire = Rxn<Commentaire>();
  late final Rxn<Etablissement> etablissement = Rxn<Etablissement>();

  Future<bool> storeCommentaire({
    String? commentaires,
    int? note,
    int? etablissementId,
  }) async {
    loading.value = true;

    try {
      final response = await ApiService.post(ApiEndPoint.CommentaireStore, {
        'commentaire': commentaires,
        'note': note,
        'etablissement': etablissementId,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        print('######### Data response : ${data['etablissement']}');
        loading.value = false;
        commentaire.value = Commentaire.fromJson(data['data']);
        etablissement.value = Etablissement.fromJson(data['etablissement'][0]);
        return true;
      }

      loading.value = false;
      return false;
    } catch (e) {
      print('Erreur server : ${e.toString()}');
      loading.value = false;
      return false;
    }
  }
}
