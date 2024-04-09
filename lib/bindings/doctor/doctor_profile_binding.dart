import 'package:aetherwell/controllers/doctor/profile_controller.dart';
import 'package:get/get.dart';

class DoctorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DoctorProfileController());
  }
}
