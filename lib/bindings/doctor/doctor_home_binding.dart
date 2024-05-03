// ignore_for_file: unused_import

import 'package:aetherwell/controllers/doctor/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:aetherwell/controllers/auth_controller.dart';

class DoctorHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DoctorHomeController());
  }
}
