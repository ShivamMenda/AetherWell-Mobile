import 'dart:convert';

import 'package:aetherwell/utils/constants.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProfileController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController address = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    final loggedinuser = authController.user;
    name.text = loggedinuser.name;
    email.text = loggedinuser.email;
    phone.text = loggedinuser.phone ?? "N/A";
    address.text = loggedinuser.address ?? "N/A";
    gender.text = loggedinuser.gender ?? "N/A";
    super.onInit();
    // Replace hardcoded values with actual values fetched from the API
  }

  void updateProfile() async {
    // Update the user profile
    Get.back();
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.patch(
      Uri.parse('$kNodeApiUrl/api/v1/users/updateProfile/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'username': authController.user.username,
        'name': name.text,
        'email': email.text,
        'phone': phone.text,
        'address': address.text,
        'gender': gender.text,
      }),
    );
    if (response.statusCode == 200) {
      authController.getUser();
      isLoading.value = false;
      Get.snackbar('Success', 'Profile updated successfully');
    } else {
      print(response.body);
      isLoading.value = false;
      Get.snackbar('Error', 'An error occurred. Please try again later');
    }
  }
}
