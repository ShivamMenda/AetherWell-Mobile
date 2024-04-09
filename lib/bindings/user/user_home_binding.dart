import 'package:get/get.dart';
import 'package:aetherwell/controllers/auth_controller.dart';

class UserHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}