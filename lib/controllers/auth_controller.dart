import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:aetherwell/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aetherwell/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final RxBool isUser = true.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  late User user;

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
          Get.offAllNamed(AppRoutes.userHome);
        } else {
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
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        'https://aetherwell-node.onrender.com/api/v1/auth/users/login');
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
      return;
    }
    final token =
        ((jsonDecode(response.body) as Map<String, dynamic>)['token'] as String)
            .split(' ')[1];
    prefs.setString('token', token);
    final id =
        ((jsonDecode(response.body) as Map<String, dynamic>)['id'] as String);
    await getUser();
    prefs.setString('id', id);
    prefs.setBool('isLoggedIn', true);
    prefs.setBool('isUser', true);
  }

  Future doctorLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        'https://aetherwell-node.onrender.com/api/v1/auth/doctors/login');
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
      Get.snackbar(
        'Error',
        'Invalid email or password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final token =
        ((jsonDecode(response.body) as Map<String, dynamic>)['token'] as String)
            .split(' ')[1];
    prefs.setString('token', token);
    prefs.setBool('isLoggedIn', true);
    prefs.setBool('isUser', false);
  }

  Future userRegister() async {
    final prefs = await SharedPreferences.getInstance();

    // On success only if not default value
    prefs.setBool('isLoggedIn', true);
    prefs.setBool('isUser', true);
  }

  Future doctorRegister() async {
    final prefs = await SharedPreferences.getInstance();

    // On success only if not default value
    prefs.setBool('isLoggedIn', true);
    prefs.setBool('isUser', false);
  }

  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('id');
    final url = Uri.parse(
        'https://aetherwell-node.onrender.com/api/v1/users/profile/${id}');
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

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.setBool('isUser', true);

    Get.offAllNamed(AppRoutes.login);
  }
}
