import 'dart:convert';

import 'package:aetherwell/routes/app_routes.dart';
import 'package:aetherwell/utils/constants.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/doctor.dart';

class UserAppointmentBookingController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<String> slots = <String>[
    "7:00 AM",
    "8:00 AM",
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "1:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM",
    "5:00 PM",
    "6:00 PM",
    "7:00 PM",
    "8:00 PM",
    "9:00 PM",
  ].obs;

  void getSlots() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final url = Uri.parse(
        "$kNodeApiUrl/api/v1/doctors/getAvailableSlots/${doctor!.id.oid}");
    convertdate();
    final body = jsonEncode(<String, String>{
      "date": selectedDate,
    });

    final response = await http.get(
      url,
      headers: headers, /*body: body*/
    );
    print(response.body);
    final data = jsonDecode(response.body)['slots'] as List;
    print(data);
    slots.clear();
    for (int i = 0; i < data.length; i++) {
      final slot = data[i] as Map<String, dynamic>;
      if (slot['status'] == "available") {
        final time = slot["start"] as String;
        slots.add(time);
      }
    }
    print(slots);
    isLoading.value = false;
  }

  void changeDate(DateTime selectedDate) {
    focusDate = selectedDate;
    //getSlots();
  }

  void getDisabledDates() {
    for (int i = 0; i <= 7; i++) {
      DateTime currentDate = startTime.add(Duration(days: i));
      if (currentDate.weekday == 6 || currentDate.weekday == 7) {
        // 6 is Saturday, 7 is Sunday
        disabledTime.add(currentDate);
      }
    }
  }

  late Doctor? doctor = Get.arguments;
  final EasyInfiniteDateTimelineController controller =
      EasyInfiniteDateTimelineController();
  DateTime startTime = DateTime.now();
  DateTime focusDate = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 7));
  List<DateTime> disabledTime = [];

  late int selectedIndex = 0;
  String selectedDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  late String selectedSlot = "7:00 AM";
  @override
  void onInit() {
    // TODO: implement onInit
    getDisabledDates();
    super.onInit();
  }

  void converTo24hr() {
    if (selectedSlot.contains("AM")) {
      selectedSlot = selectedSlot.replaceAll(" AM", "");
    } else if (selectedSlot.contains("PM")) {
      selectedSlot = selectedSlot.replaceAll(" PM", "");
      final hrs = (int.parse(selectedSlot.split(":")[0]) + 12).toString();
      selectedSlot = "$hrs:${selectedSlot.split(":")[1]}";
    }

    selectedSlot = selectedSlot;
  }

  String getEndTime() {
    final hrs = (int.parse(selectedSlot.split(":")[0]) + 1).toString();
    return "$hrs:${selectedSlot.split(":")[1]}";
  }

  void convertdate() {
    selectedDate = DateFormat("dd-MM-yyyy").format(focusDate);
  }

  Future bookAppointment(Doctor doctor) async {
    converTo24hr();
    convertdate();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final body = jsonEncode(<String, String>{
      "doctorId": doctor.id.oid,
      "date": selectedDate,
      "startTime": selectedSlot,
      "endTime": getEndTime(),
    });
    print(body);

    final url = Uri.parse("$kNodeApiUrl/api/v1/users/bookAppointment");
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      final data = jsonDecode(response.body);
      print(data);
      Get.snackbar(
        "Success",
        data["message"],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
      Get.offAllNamed(AppRoutes.userAppointments);
    } else {
      print(response.statusCode);
      final data = jsonDecode(response.body);
      print(data);
      Get.snackbar(
        "Error",
        data["message"],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}
