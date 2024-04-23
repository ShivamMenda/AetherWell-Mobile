import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/appointments.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;
class DoctorPatientController extends GetxController {
  List<Appointment> patientList = [];
  List<String> patientListProfile = [];
  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await getFullListOnDay();

    super.onInit();
  }

  Future getFullListOnDay() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      final url = Uri.parse('$kNodeApiUrl/api/v1/doctors/appointments');
      final response = await http.get(
        url,
        headers: header,
      );
      if (response.statusCode != 200) {
        print(response.body);
        print("Something went wrong");
        print(response.statusCode);
        return;
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      patientList = (data['appointments'] as List)
          .map((appointmentJson) => Appointment.fromJSON(appointmentJson))
          .toList();

      //Now get the full patient details
      for (int i = 0; i < patientList.length; i++) {
        print(patientList[i].userId);

      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }



}