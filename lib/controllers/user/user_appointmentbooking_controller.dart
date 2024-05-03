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

  RxList<String> slots = <String>[].obs;

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
      "date": selectedDate.value,
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

  late Doctor? doctor = Get.arguments;
  final EasyInfiniteDateTimelineController controller =
      EasyInfiniteDateTimelineController();
  DateTime startTime = DateTime.now();
  DateTime focusDate = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 7));
  List<DateTime> disabledTime = [];

  late int selectedIndex = 0;
  late RxString selectedDate=DateFormat("dd-MM-yyyy").format(DateTime.now()).obs;
  late String selectedSlot = "7:00 AM";
  @override
  void onInit() {
    // TODO: implement onInit
    getDaysSlots();
    super.onInit();
  }
  void getDaysSlots(){
    slots.clear();
    DateTime currentTime=new DateTime.now();
    int hours=currentTime.hour;
    print(selectedDate);
    DateTime parsedSelectedDate = DateFormat("dd-MM-yyyy").parse(selectedDate.value);
    bool isToday = currentTime.year == parsedSelectedDate.year &&
        currentTime.month == parsedSelectedDate.month &&
        currentTime.day == parsedSelectedDate.day;

    for(int i=7;i<21;i++){

      if(isToday) {
        if (i > hours) {
          slots.add(getTime(i));
        }
      }else{
        slots.add(getTime(i));
      }
    }
    if(slots.isNotEmpty){
      selectedSlot=slots[0];
    }else{
      selectedSlot="";
    }
    print(slots);
  }

  String getTime(int time){
    String currTime="";

    switch (time){
      case 7:currTime="7:00";break;
      case 8:currTime="8:00";break;
      case 9:currTime="9:00";break;
      case 10:currTime="10:00";break;
      case 11:currTime="11:00";break;
      case 12:currTime="12:00";break;
      case 13:currTime="13:00";break;
      case 14:currTime="14:00";break;
      case 15:currTime="15:00";break;
      case 16:currTime="16:00";break;
      case 17:currTime="17:00";break;
      case 18:currTime="18:00";break;
      case 19:currTime="19:00";break;
      case 20:currTime="20:00";break;
      case 21:currTime="21:00";break;
    }
    return currTime;
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
    selectedDate.value = DateFormat("dd-MM-yyyy").format(focusDate);
  }

  Future bookAppointment(Doctor doctor) async {
   // converTo24hr();
    convertdate();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final body = jsonEncode(<String, String>{
      "doctorId": doctor.id.oid,
      "date": selectedDate.value,
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
