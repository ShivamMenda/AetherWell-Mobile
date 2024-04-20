import 'package:aetherwell/views/widgets/custom_drawer.dart';
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
    final loggedinuser=authController.user;
    name.text = loggedinuser.name;
    email.text = loggedinuser.email;
    phone.text = loggedinuser.phone??"N/A";
    address.text = loggedinuser.address??"N/A";
    gender.text = loggedinuser.gender??"N/A";
    super.onInit();
    // Replace hardcoded values with actual values fetched from the API
  }
}
