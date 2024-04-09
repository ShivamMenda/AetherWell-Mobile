import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  void onInit() {
    name.text = "User Name";
    email.text = "User Email";
    phone.text = "Phone Number";
    address.text = "Address";
    gender.text = "Male/Female";
    super.onInit();
    // Replace hardcoded values with actual values fetched from the API
  }
}
