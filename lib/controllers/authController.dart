import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/services/apiService.dart';
import 'package:mobile/utils/apiEndPoint.dart';
import 'package:mobile/utils/helper.dart';
import 'package:dio/dio.dart' as dio;

//Controller of Authenticated User
class AuthController extends GetxController {
  final Rx<User?> user = Rx<User?>(null);
  final RxString userEmailError = ''.obs;
  final RxString userPasswordError = ''.obs;
  final RxBool isLogdedIn = false.obs;
  final RxBool loading = false.obs;
  final RxString errors = ''.obs;
  final RxString selectedImagePath = ''.obs;

  final _storage = GetStorage();
  final _tokenKey = 'auth_token';
  final _userKey = 'user_data';

  final ImagePicker _picker = ImagePicker();

  //Getter pour verifier si l'utilisateur est connecté
  bool get isAuthenticated => user.value != null && getToken() != null;

  //Login function
  Future<void> login(
    String userEmail,
    String userPassword,
    bool souvenir,
  ) async {
    loading.value = true;

    try {
      //On verifie si les champs email et password ne sont pas vide
      if (!validateFields(userEmail, userPassword)) return;

      //Request post vers l'api
      final response = await ApiService.post(
          ApiEndPoint.Login, {'email': userEmail, 'password': userPassword});

      //On verifie si tout s'est bien passé avec l'api et on recupere les infos retournées
      if (response.statusCode == 200) {
        final data = response.data;

        //Sauvegarde des infos dans le storage local
        await _storage.write(_tokenKey, data['access_token']);
        await _storage.write(_userKey, jsonEncode(data['user']));

        user.value = User.fromJson(data['user']);

        printStorageContent();

        //Redirection vers la page home
        Get.offAllNamed('/navigation');
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;
      print('Une erreur s\'est produite : ${e.toString()}');
    }
  }

  //User register
  Future<void> register(Object data) async {
    loading.value = true;

    try {
      final response = await ApiService.post(ApiEndPoint.Register, data);

      if (response.statusCode == 200) {
        final dataJson = response.data;

        await _storage.write(_tokenKey, dataJson['access_token']);
        await _storage.write(_userKey, dataJson['user']);

        user.value = User.fromJson(dataJson['user']);

        //Redirection vers la page home
        Get.offAllNamed('/navigation');
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;
      print('Une erreur s\'est produite : ${e.toString()}');
    }
  }

  bool validateFields(String userEmail, String userPassword) {
    bool isValid = true;

    userEmailError.value = '';
    userPasswordError.value = '';

    if (userEmail.isEmpty) {
      userEmailError.value = 'Veuillez renseigner votre adresse email';
      isValid = false;
      loading.value = false;
    }

    if (userPassword.isEmpty) {
      userPasswordError.value = 'Veuillez renseigner votre mot de passe';
      isValid = false;
      loading.value = false;
    }

    return isValid;
  }

  //Deconnexion
  Future<void> logout() async {
    try {
      await _storage.remove(_tokenKey);
      await _storage.remove(_userKey);
      user.value = null;
      Get.offAllNamed('/login');
    } catch (e) {
      print('Erreur lors de la deconnexion: $e');
    }
  }

  //Restauration de la session
  Future<void> restoreSession() async {
    try {
      final token = getToken();
      final userData = _storage.read(_userKey);

      printStorageContent();

      if (token != null && userData != null) {
        user.value = User.fromJson(jsonDecode(userData));
        Get.offAllNamed('/navigation');
      } else {
        showSnackBarWidget(
          type: 'error',
          content:
              'Votre session a été interrompue ! Veuillez vous connecter svp.',
        );
        throw Exception('Session expiré');
      }
    } catch (e) {
      print('Erreur lors de la restauration de la session: $e');
      logout();
    }
  }

  //Recuperation du token
  String? getToken() {
    return _storage.read(_tokenKey);
  }

  //Modification du profil
  Future updateProfile(Object data) async {
    try {
      loading.value = true;

      final response = await ApiService.post(ApiEndPoint.UpdateProfile, data);

      if (response.statusCode == 200) {
        final dataJson = response.data;
        await _storage.write(_userKey, dataJson['data']);
        user.value = User.fromJson(dataJson['data']);
        loading.value = false;
        return true;
      }

      loading.value = false;
      showDialogWidget(
        'Oups !',
        'Une erreur inattendue s\'est produite. Veuillez réessayer svp.',
      );
      return false;
    } catch (e) {
      loading.value = false;
      print('Erreur lors de la modification du profil: $e');
      return false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImagePath.value = image.path;
      updatedProfileImage();
    }
  }

  Future<void> updatedProfileImage() async {
    if (selectedImagePath.value == '') {
      showSnackBarWidget(
          type: 'error', content: 'Veuillez sélectionner une image svp.');
      return;
    }

    try {
      // Préparation du fichier
      dio.FormData formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(
          selectedImagePath.value,
          filename: selectedImagePath.value.split('/').last,
        )
      });

      //Envoie de la requete
      final response =
          await ApiService.post(ApiEndPoint.UpdateProfileImage, formData);

      if (response.statusCode == 200) {
        final data = response.data;
        user.value = User.fromJson(data['data']);
        Get.back();
      }
    } catch (e) {
      print('Http Error : ${e.toString()}');
    }
  }

  void printStorageContent() {
    print('################# Contenu du storage: ##################');
    print('Token: ${_storage.read(_tokenKey)}');
    print('User: ${_storage.read(_userKey)}');
    print('################# Fin ##################');
  }
}
