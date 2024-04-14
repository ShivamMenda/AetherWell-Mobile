import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/doctor.dart';

class UserAppointmentBookingController extends GetxController {
  void changeDate(DateTime selectedDate){
    focusDate=selectedDate;
  }
  void getDisabledDates() {
    for (int i = 0; i <= 7; i++) {
      DateTime currentDate = startTime.add(Duration(days: i));
      if (currentDate.weekday == 6 || currentDate.weekday == 7) { // 6 is Saturday, 7 is Sunday
        disabledTime.add(currentDate);
      }
    }
  }

  late Doctor?doctor;
  final EasyInfiniteDateTimelineController controller =
  EasyInfiniteDateTimelineController();
  DateTime startTime=DateTime.now();
  DateTime focusDate = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 7));
  List<DateTime>disabledTime=[];

  late int selectedIndex=0;
  late int selectedSlot=0;
  @override
  void onInit() {
    // TODO: implement onInit
    getDisabledDates();
    super.onInit();
  }

}