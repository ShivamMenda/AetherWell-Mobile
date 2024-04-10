import 'package:aetherwell/controllers/doctor/availbility_management.dart';
import 'package:aetherwell/controllers/doctor/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:aetherwell/controllers/auth_controller.dart';

class DoctorAvailbilityManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DoctorAvailbilityController());
  }
}