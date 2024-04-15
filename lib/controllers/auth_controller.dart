import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:aetherwell/models/doctor.dart';
import 'package:aetherwell/models/user.dart';
import 'package:aetherwell/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aetherwell/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxBool isUser = true.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString username = ''.obs;
  final RxString fullName = ''.obs;
  final RxString age = ''.obs;
  final RxString address = ''.obs;
  final RxString phone = ''.obs;
  final RxString gender = ''.obs;
  late User user;
  late Doctor doctor;

  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    isUser.value = prefs.getBool('isUser') ?? true;
    log('isLoggedIn: ${isLoggedIn.value}');
    log('isUser: ${isUser.value}');
    await isUserLoggedIn();
    super.onInit();
  }

  Future getLoginState() async {
    try {
      if (isLoggedIn.value == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future isUserLoggedIn() async {
    try {
      if (await getLoginState() == true) {
        if (isUser.value == true) {
          await getUser();
          Get.offAllNamed(AppRoutes.userHome);
        } else {
          await getDoctor();
          Get.offAllNamed(AppRoutes.doctorHome);
        }
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      log(e.toString());
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future userLogin() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('$kNodeApiUrl/api/v1/auth/users/login');
    final body = jsonEncode({
      'email': email.value,
      'password': password.value,
    });
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    log('Response status: ${response.statusCode}');

    if (response.statusCode != 200) {
      log('Response body: ${response.body}');
      prefs.setBool('isLoggedIn', false);
      prefs.setBool('isUser', true);
      isLoading.value = false;
      Get.snackbar(
        "Fail",
        "Invalid email or password",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final token =
        ((jsonDecode(response.body) as Map<String, dynamic>)['token'] as String)
            .split(' ')[1];
    prefs.setString('token', token);
    final id =
        ((jsonDecode(response.body) as Map<String, dynamic>)['id'] as String);

    prefs.setString('id', id);
    prefs.setBool('isLoggedIn', true);
    prefs.setBool('isUser', true);
    await getUser();
    isLoading.value = false;
    Get.snackbar(
      'Success',
      'User logged in',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color(Colors.green.value),
      colorText: Color(Colors.white.value),
    );
    Get.offAllNamed(AppRoutes.userHome);
  }

  Future doctorLogin() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('$kNodeApiUrl/api/v1/auth/doctors/login');
    final body = jsonEncode({
      'email': email.value,
      'password': password.value,
    });
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    log('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      log('Response body: ${response.body}');
      prefs.setBool('isLoggedIn', false);
      prefs.setBool('isUser', false);
      Get.snackbar(
        "Fail",
        "Invalid email or password",
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      // Get.offAllNamed(AppRoutes.login);
      return;
    }
    final token =
        ((jsonDecode(response.body) as Map<String, dynamic>)['token'] as String)
            .split(' ')[1];
    prefs.setString('token', token);
    prefs.setBool('isLoggedIn', true);
    prefs.setBool('isUser', false);
    final id =
        ((jsonDecode(response.body) as Map<String, dynamic>)['id'] as String);
    prefs.setString('id', id);
    await getDoctor();
    Get.snackbar(
      'Success',
      'Doctor logged in',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color(Colors.green.value),
      colorText: Color(Colors.white.value),
    );
    isLoading.value = false;
    Get.offAndToNamed(AppRoutes.doctorHome);
  }

  Future userRegister() async {
    final prefs = await SharedPreferences.getInstance();
    print(email.value);
    print(password.value);
    print(username.value);
    print(age.value);
    print(gender.value);
    print(address.value);
    print(phone.value);
    print(fullName.value);

    final url = Uri.parse('$kNodeApiUrl/api/v1/auth/users/register');
    final body = jsonEncode({
      'email': email.value,
      'password': password.value,
      'name': fullName.value,
      'username': username.value,
      'age': age.value,
      'gender': gender.value,
      'address': address.value,
      'phone': phone.value,
    });

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    log('Response status: ${response.statusCode}');
    if (response.statusCode != 201) {
      log('Response body: ${response.body}');
      prefs.setBool('isLoggedIn', false);
      prefs.setBool('isUser', true);
      Get.snackbar(
        "Fail",
        "Failed to register user",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.snackbar(
      'Success',
      'User registered',
      snackPosition: SnackPosition.BOTTOM,
    );
    await userLogin();
    // On success only if not default value
    prefs.setBool('isLoggedIn', true);
    prefs.setBool('isUser', true);
  }

  Future doctorRegister() async {
    final prefs = await SharedPreferences.getInstance();
    print(email.value);
    print(password.value);
    print(username.value);
    print(age.value);
    print(gender.value);
    //Prints specialisation =>user.address===doctor.specialisation same controller
    print(address.value);
    //Prints Hospital => user.phone===doctor.hospital same controller
    print(phone.value);
    print(fullName.value);
    // On success only if not default value

    final url = Uri.parse('$kNodeApiUrl/api/v1/auth/doctors/register');
    final body = jsonEncode({
      'email': email.value,
      'password': password.value,
      'name': fullName.value,
      'username': username.value,
      'age': age.value,
      'gender': gender.value,
      'specialization': address.value,
      'hospital': phone.value,
      'role': 'doctor',
    });

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    log('Response status: ${response.statusCode}');
    if (response.statusCode != 201) {
      log('Response body: ${response.body}');
      prefs.setBool('isLoggedIn', false);
      prefs.setBool('isUser', false);
      Get.snackbar(
        "Fail",
        "Failed to register doctor",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.snackbar(
      'Success',
      'Doctor registered',
      snackPosition: SnackPosition.BOTTOM,
    );
    await doctorLogin();
    prefs.setBool('isLoggedIn', true);
    prefs.setBool('isUser', false);
  }

  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('id');
    final url = Uri.parse('$kNodeApiUrl/api/v1/users/profile/$id');
    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      url,
      headers: header,
    );
    log('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      log('Response body: ${response.body}');
      return;
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    user = User.fromJSON(data['profile'] as Map<String, dynamic>, id!);
    Get.snackbar(
      'Success',
      'User data fetched',
      snackPosition: SnackPosition.BOTTOM,
    );
    log(user.name);
    log(user.email);
    log(user.id.toString());
  }

  Future getDoctor() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('id');
    final url = Uri.parse('$kNodeApiUrl/api/v1/doctors/profile/$id');
    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      url,
      headers: header,
    );
    log('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      log('Response body: ${response.body}');
      return;
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    data['profile']['availability'] = [];
    doctor = Doctor.fromJson(data['profile'] as Map<String, dynamic>, id!);
    Get.snackbar(
      'Success',
      'Doctor data fetched',
      snackPosition: SnackPosition.BOTTOM,
    );
    log(doctor.name);
    log(doctor.email);
    log(doctor.id.toString());
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.setBool('isUser', true);

    Get.offAllNamed(AppRoutes.login);
  }
}
