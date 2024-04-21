import 'dart:convert';
import 'dart:developer';
import 'package:aetherwell/models/appointments.dart';
import 'package:aetherwell/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DoctorAppointmentController extends GetxController {
  List<Appointment> appointmentList = [];
  List<String> appointmentListNames = [];
  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await getFullList();
    super.onInit();
  }

  Future getFullList() async {
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
      appointmentList = (data['appointments'] as List)
          .map((appointmentJson) => Appointment.fromJSON(appointmentJson))
          .toList();
      for (int i = 0; i < appointmentList.length; i++) {
        final string = (appointmentList[i].userId['name']);
        appointmentListNames.add(string);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
