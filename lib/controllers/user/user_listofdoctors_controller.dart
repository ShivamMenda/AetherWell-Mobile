import 'dart:convert';

import 'package:aetherwell/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/doctor.dart';

class ListOfDoctorsController extends GetxController {
  late RxList<Doctor> doctorsList;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    doctorsList = <Doctor>[].obs;
    await getDoctors();
    super.onInit();
  }

  Future getDoctors() async {
    isLoading.value = true;
    final docList = <Doctor>[];
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    final url = Uri.parse('$kNodeApiUrl/api/v1/users/getAllDoctors');
    final response = await http.get(url, headers: header);
    final responseData =
        (jsonDecode(response.body) as Map<String, dynamic>)['doctors'] as List;
    for (final doctor in responseData) {
      docList.add(
        Doctor.fromJson(
            doctor as Map<String, dynamic>, doctor['_id'] as String),
      );
    }
    doctorsList.value = docList;
    isLoading.value = false;
  }
}
