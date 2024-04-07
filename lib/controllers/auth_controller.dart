import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aetherwell/routes/app_routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final RxBool isUser = true.obs;
  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    isUser.value = prefs.getBool('isUser') ?? true;
    log('isLoggedIn: ${isLoggedIn.value}');
    log('isUser: ${isUser.value}');
    await isUserLoggedIn();
    super.onInit();
  }

  Future getLoginState() async {
    try {
      if (isLoggedIn.value == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future isUserLoggedIn() async {
    try {
      if (await getLoginState() == true) {
        if (isUser.value == true) {
          Get.offAllNamed(AppRoutes.userHome);
        } else {
          Get.offAllNamed(AppRoutes.doctorHome);
        }
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      log(e.toString());
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void userLogin() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      // On success only if not default value
      value.setBool('isLoggedIn', true);
      value.setBool('isUser', true);
    });
  }

  void doctorLogin() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      // On success only if not default value
      value.setBool('isLoggedIn', true);
      value.setBool('isUser', false);
    });
  }

  void userRegister() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      // On success only if not default value
      value.setBool('isLoggedIn', true);
      value.setBool('isUser', true);
    });
  }

  void doctorRegister() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      // On success only if not default value
      value.setBool('isLoggedIn', true);
      value.setBool('isUser', false);
    });
  }

  void logout() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      // On success only if not default value
      value.setBool('isLoggedIn', false);
      value.setBool('isUser', true);
    });
    Get.offAllNamed(AppRoutes.login);
  }
}
