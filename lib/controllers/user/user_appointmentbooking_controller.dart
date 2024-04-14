import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/doctor.dart';

class UserAppointmentBookingController extends GetxController {
  void changeDate(DateTime selectedDate){
    focusDate=selectedDate;
  }
  late Doctor?doctor;
  final EasyInfiniteDateTimelineController controller =
  EasyInfiniteDateTimelineController();
  DateTime startTime=DateTime.now();
  DateTime focusDate = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 7));
  late int selectedIndex=0;

}