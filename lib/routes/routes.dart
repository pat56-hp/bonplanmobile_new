import 'package:get/get.dart';
import 'package:mobile/views/auth/login.dart';
import 'package:mobile/views/auth/passwordReset.dart';
import 'package:mobile/views/homeScreen.dart';
import 'package:mobile/views/onboarding.dart';
import 'package:mobile/views/search.dart';
import 'package:mobile/views/splash.dart';
import 'package:mobile/views/widgets/navigation/bottomNavigation.dart';
import 'package:mobile/views/DetailPlan.dart';
import 'package:mobile/views/ExploreScreen.dart';
import 'package:mobile/views/FavorisScreen.dart';
import 'package:mobile/views/ProfilScreen.dart';
import 'package:mobile/views/auth/Register.dart';

class Routes {
  static List<GetPage<dynamic>> appRoutes = [
    GetPage(name: '/', page: () => const HomeScreen()),
    GetPage(name: '/splash_screen', page: () => const SplashSreen()),
    GetPage(name: '/onboarding', page: () => const Onboarding()),
    GetPage(name: '/navigation', page: () => const Navigation()),
    GetPage(name: '/explore', page: () => const ExploreScreen()),
    GetPage(name: '/search', page: () => const Search()),
    GetPage(name: '/favoris', page: () => const FavorisScreen()),
    GetPage(name: '/profil', page: () => const ProfilScreen()),
    GetPage(name: '/detailPlan', page: () => const DetailPlan()),
    GetPage(name: '/login', page: () => const Login()),
    GetPage(name: '/register', page: () => const Register()),
    GetPage(name: '/passwordReset', page: () => const PasswordReset()),
  ];
}
