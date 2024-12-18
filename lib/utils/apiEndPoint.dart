abstract class ApiEndPoint {
  static const String apiUrlDomaine = 'http://192.168.1.134:8000';
  static const String apiUrl = apiUrlDomaine + '/api/v1';
  static const String Login = '/login';
  static const String Register = '/register';
  static const String UpdateProfile = '/profile/update';
  static const String UpdateProfileImage = '/profile/update/image';
  static const String HomeData = apiUrl + '/homeData';
  static const String Categories = apiUrl + '/categories';
  static const String Commodites = apiUrl + '/commodites';
  static const String ExplorePlan = apiUrl + '/explore-plans';
  static const String AddOrRemoveFavoris = apiUrl + '/etablissements/favoris';
  static const String Favoris = apiUrl + '/favoris/etablissement';
  static const String CommentaireStore = apiUrl + '/commentaires/store';
}
