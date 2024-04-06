import 'package:aetherwell/bindings/splash_binding.dart';

import 'app_routes.dart';
import 'package:get/get.dart';
import 'package:aetherwell/views/screens/splash_screen.dart';
import 'package:aetherwell/views/screens/home_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
  ];
}
