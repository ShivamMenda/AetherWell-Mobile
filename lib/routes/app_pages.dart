import 'package:aetherwell/bindings/doctor/doctor_home_binding.dart';
import 'package:aetherwell/bindings/login_binding.dart';
import 'package:aetherwell/bindings/signup_binding.dart';
import 'package:aetherwell/bindings/splash_binding.dart';
import 'package:aetherwell/views/screens/doctor/home_screen.dart';
import 'package:aetherwell/views/screens/login_screen.dart';
import 'package:aetherwell/views/screens/signup_screen.dart';
import 'app_routes.dart';
import 'package:get/get.dart';
import 'package:aetherwell/views/screens/splash_screen.dart';
import 'package:aetherwell/views/screens/user/home_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.userHome,
      page: () => UserHomeScreen(),
    ),
    GetPage(
      name: AppRoutes.doctorHome,
      page: () => DoctorHomeScreen(),
      binding: DoctorHomeBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignUpScreen(),
      binding: SignupBinding(),
    ),
  ];
}
