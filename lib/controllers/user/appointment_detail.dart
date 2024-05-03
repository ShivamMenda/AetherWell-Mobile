import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:aetherwell/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentDetailController extends GetxController {
  Future cancelAppointment(final aid, final did) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('$kNodeApiUrl/api/v1/users/cancelAppointment');
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(<String, String>{
      'aid': aid,
      'did': did,
    });
    final response = await http.delete(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response.body);
      Get.snackbar(
        'Success',
        'Appointment cancelled successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      log(response.statusCode);
      print(response.body);
      Get.snackbar(
        'Error',
        'Failed to cancel appointment',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
