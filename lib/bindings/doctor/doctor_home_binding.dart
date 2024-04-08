import 'package:get/get.dart';
import 'package:aetherwell/controllers/auth_controller.dart';

class DoctorHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}