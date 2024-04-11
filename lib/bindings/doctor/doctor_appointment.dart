// ignore_for_file: unused_import

import 'package:aetherwell/controllers/doctor/appointment.dart';
import 'package:aetherwell/controllers/doctor/availbility_management.dart';
import 'package:aetherwell/controllers/doctor/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:aetherwell/controllers/auth_controller.dart';

class DoctorAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DoctorAppointmentController());
  }
}