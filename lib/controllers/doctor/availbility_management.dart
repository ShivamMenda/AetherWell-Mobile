// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/appointments.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

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
  // final appointmentsNumber="";
  // final patientNumber ="";

  DateTime startOfWeek(DateTime date) {
    int dayOfWeek = date.weekday; // Monday = 1, Sunday = 7
    return date.subtract(Duration(days: dayOfWeek - 1));
  }

  DateTime endOfWeek(DateTime date) {
    int dayOfWeek = date.weekday;
    return date.add(Duration(days: 7 - dayOfWeek));
  }

  //Dummy Data
  // PieChartData('Excellent', 45),
  // PieChartData('Good', 30),
  // PieChartData('Fair', 12),
  List<PieChartData> piChartData = [];
  //Inflow Data
  // InflowData("Mon", 25.0),
  // InflowData("Tue", 45.0),
  // InflowData("Wed", 35.0),
  // InflowData("Thu", 15.0),
  // InflowData("Fri", 55.0),
  List<InflowData> inflowData = [];
  //Fetch total appointments
  List<Appointment> appointmentList = [];
  List<String> appointmentListNames = [];
  List<Appointment>thisWeeksAppointmentList=[];
  List<String>thisWeeksAppointmentListNames=[];
  List<Appointment> patientList= [];
  final RxBool isLoading = false.obs;
  final RxInt totalAppointments=0.obs;
  final RxInt thisWeeksAppointments=0.obs;
  final RxString appointmentsNumber="".obs;
  final RxString patientNumbers="".obs;
  DateTime todayDate = DateTime.now();
  late DateTime weekStart;
  late DateTime weekEnd;
  String?yaxisName;
  @override
  void onInit() async {
    weekStart = startOfWeek(todayDate);
    weekEnd = endOfWeek(todayDate);
    yaxisName="Day of the Month";
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
      thisWeeksAppointmentList = thisWeeksAppointmentList = appointmentList.where((appointment) {
        DateTime appointmentDate = DateTime(
          appointment.date.year,
          appointment.date.month,
          appointment.date.day,
        );
        return appointmentDate.isAfter(weekStart.subtract(Duration(seconds: 1))) &&
            appointmentDate.isBefore(weekEnd.add(Duration(seconds: 1)));
      }).toList();

      thisWeeksAppointmentListNames = thisWeeksAppointmentList.map((appointment) {
        return appointment.userId['name'] as String;
      }).toList();

      thisWeeksAppointments.value = thisWeeksAppointmentList.length;
      // Convert the list of JSON objects into a Set then to a list of Appointment objects
      List<Appointment> rawAppointmentList = (data['appointments'] as List)
          .map((appointmentJson) => Appointment.fromJSON(appointmentJson))
          .toList();

      // Convert the list to a Set to remove duplicates and then back to a List
      Set<Appointment> uniqueAppointmentsSet = rawAppointmentList.toSet();
      patientList= uniqueAppointmentsSet.toList();


      //Now get the full patient details
      for (int i = 0; i < patientList.length; i++) {
        print(patientList[i].userId);
      }

      //Set all analytics Data
      appointmentsNumber.value=appointmentList.length.toString();
      patientNumbers.value=patientList.length.toString();

      //Status of Appointments
      Map<String,dynamic>m={};
      for(int i=0;i<appointmentList.length;i++){
        if(m.containsKey(appointmentList[i].status.name)){
          m.update(appointmentList[i].status.name, (value) => value+1);
        }else{
          m[appointmentList[i].status.name]=1;
        }
      }

      //Now from Map to Pie chart Data
      m.forEach((key, value) {piChartData.add(PieChartData(key,value));});

      //this week's Appointment List
      Map<int,int>m1={};
      for(int i=0;i<7;i++){
        DateTime thisDay=weekStart.add(Duration(days: i));
        print(thisDay.day);
        m1[thisDay.day]=0;
      }
      for(int i=0;i<thisWeeksAppointmentList.length;i++){
        m1.update(thisWeeksAppointmentList[i].date.day, (value) => value+1);
      }
      m1.forEach((key, value) {inflowData.add(InflowData("${key}", value.toDouble()));});
      print(inflowData);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

}
