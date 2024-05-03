import 'package:aetherwell/controllers/user/user_profile_controller.dart';
import 'package:get/get.dart';
import 'package:aetherwell/controllers/auth_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserProfileController>(UserProfileController());
  }
}
