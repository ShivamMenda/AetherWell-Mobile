// ignore_for_file: unused_import

import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PieChartData {
  final String category;
  final int value;

  PieChartData(this.category, this.value);
}

class InflowData {
  InflowData(this.day, this.number);
  final String day;
  final double number;
}

class DoctorAvailbilityController extends GetxController {
  final appointmentsNumber = "1925";
  final patientNumber = "153";

  List<PieChartData> piChartData = [
    PieChartData('Excellent', 45),
    PieChartData('Good', 30),
    PieChartData('Fair', 12),
  ];
  List<InflowData> inflowData = [
    InflowData("Mon", 25.0),
    InflowData("Tue", 45.0),
    InflowData("Wed", 35.0),
    InflowData("Thu", 15.0),
    InflowData("Fri", 55.0),
  ];
  void init() {
    //TODO:Fetch from api
    // appointmentsNumber=1925;
    // patientNumber=153;
  }
}
