import 'dart:convert';
import 'dart:developer';

import 'package:aetherwell/models/appointments.dart';
import 'package:aetherwell/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppointmentDisplay extends Appointment {
  final String doctorName;
  AppointmentDisplay({
    required this.doctorName,
    required id,
    required doctorId,
    required userId,
    required date,
    required startTime,
    required endTime,
    required status,
  }) : super(
          id: id,
          doctorId: doctorId,
          userId: userId,
          date: date,
          startTime: startTime,
          endTime: endTime,
          status: status,
        );

  AppointmentDisplay.fromAppointment(Appointment appointment, this.doctorName)
      : super(
          id: appointment.id,
          doctorId: appointment.doctorId,
          userId: appointment.userId,
          date: appointment.date,
          startTime: appointment.startTime,
          endTime: appointment.endTime,
          status: appointment.status,
        );
}

class UserHomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<AppointmentDisplay> appointmentList = <AppointmentDisplay>[].obs;

  @override
  void onInit() async {
    await fetchAppointments();
    super.onInit();
  }

  Future<String> getDoctor(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

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
      return "Error";
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return data['profile']['name'];
  }

  Future fetchAppointments() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('$kNodeApiUrl/api/v1/users/appointments');
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      final List<dynamic> data = responseData['appointments'];
      final List<AppointmentDisplay> appointmentsLi = [];
      for (final app in data) {
        final doctorName = await getDoctor(app['doctorId']);
        appointmentsLi.add(AppointmentDisplay.fromAppointment(
          Appointment.fromJSON(app as Map<String, dynamic>),
          doctorName,
        ));
      }
      appointmentList.value = appointmentsLi;
      log(appointmentList.toString());
    } else {
      Get.snackbar(
        'Error',
        'Failed to fetch appointments',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading.value = false;
  }
}
