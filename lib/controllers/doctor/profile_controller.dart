import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:aetherwell/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController specialization = TextEditingController();
  final TextEditingController clinic = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Replace hardcoded values with actual values fetched from the API
    final doc = authController.doctor;
    name.text = doc.name;
    email.text = doc.email;
    phone.text = doc.phone ?? 'N/A';
    specialization.text = doc.specialization;
    clinic.text = doc.hospital;
    gender.text = doc.gender ?? "N/A";
    aboutController.text = "A passionate working professional";
  }
}
