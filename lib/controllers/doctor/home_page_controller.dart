import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/appointments.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

class DoctorHomeController extends GetxController {
  List<Appointment> appointmentList = [];
  List<String> appointmentListNames = [];
  List<Appointment>todaysAppointmentList=[];
  List<String>todaysAppointmentListNames=[];
  final RxBool isLoading = false.obs;
  final RxInt totalAppointments=0.obs;
  final RxInt todaysAppointments=0.obs;
  DateTime today = DateTime.now();
  late DateTime todayDate;
  @override
  void onInit() async {
    todayDate = DateTime(today.year, today.month, today.day);
    await getFullListOnDay();
    await updateNumbers();
    super.onInit();
  }

  Future<void>updateNumbers()async{

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
      appointmentList = (data['appointments'] as List)
          .map((appointmentJson) => Appointment.fromJSON(appointmentJson))
          .toList();

      for (int i = 0; i < appointmentList.length; i++) {
        final string = (appointmentList[i].userId['name']);
        appointmentListNames.add(string);
      }

      //Now Set the Length of total List and filter the thing

      totalAppointments.value=appointmentList.length;


      //Filter it
      todaysAppointmentList = appointmentList.where((appointment) {
        DateTime appointmentDate = DateTime(
          appointment.date.year,
          appointment.date.month,
          appointment.date.day,
        );
        return appointmentDate == todayDate;
      }).toList();

      todaysAppointmentListNames = todaysAppointmentList.map((appointment) {
        return appointment.userId['name'] as String;
      }).toList();

      todaysAppointments.value = todaysAppointmentList.length;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
