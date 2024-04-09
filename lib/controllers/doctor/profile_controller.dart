import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController specialization = TextEditingController();
  final TextEditingController clinic = TextEditingController();
  final TextEditingController experience = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Replace hardcoded values with actual values fetched from the API
    name.text = "Doctor Name";
    email.text = "Doctor Email";
    phone.text = "Phone Number";
    specialization.text = "Cardiology";
    clinic.text = "Clinic Name / Hospital Name";
    experience.text = "2";
  }
}
