import 'dart:convert';

import 'package:aetherwell/models/appointments.dart';
import 'package:aetherwell/utils/constants.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart';
class DoctorAppointmentController extends GetxController {
  //Dummy List
  // List<Map<String, String>> appointmentList = [
  //   {
  //     'patientName': 'John Doe',
  //     'diagnostics': 'Fever',
  //     'gender': 'Male',
  //     'status':'confirmed',
  //   },
  //   {
  //     'patientName': 'Jane Smith',
  //     'diagnostics': 'Headache',
  //     'gender': 'Female',
  //     'status':'cancelled',
  //   },
  //   {
  //     'patientName': 'David Johnson',
  //     'diagnostics': 'Sore throat',
  //     'gender': 'Male',
  //     'status':'confirmed',
  //   },
  //   {
  //     'patientName': 'Emily Brown',
  //     'diagnostics': 'Cough',
  //     'gender': 'Female',
  //     'status':'confirmed',
  //   },
  //   {
  //     'patientName': 'Michael Williams',
  //     'diagnostics': 'Fatigue',
  //     'gender': 'Male',
  //     'status':'confirmed',
  //   },
  // ];

  //Fetching logic
  List<Appointment>appointmentList=[];
  List<String>appointmentListNames=[];
  Future<String>getName(String uuid)async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    final url=Uri.parse('$kNodeApiUrl/api/v1/users/getName/$uuid');
    final response=await http.get(url,headers: header);
    if(response.statusCode!=200){
      print("Something went wrong");
      print(response.body);
      print(response.statusCode);
      return "";
    }
    final data=jsonDecode(response.body) as Map<String,dynamic>;
    return data["name"];
  }
  Future<void> getFullList()async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

  final url=Uri.parse('$kNodeApiUrl/api/v1/doctors/appointments');
  final response=await http.get(
      url,
      headers: header,
  );
  if(response.statusCode!=200){
    print(response.body);
    print("Something went wrong");
    print(response.statusCode);
    return;
  }
  final data=jsonDecode(response.body) as Map<String,dynamic>;
  appointmentList=(data['appointments'] as List)
      .map((appointmentJson) => Appointment.fromJSON(appointmentJson))
      .toList();
  for(int i=0;i<appointmentList.length;i++){
    final string=await getName(appointmentList[i].userId.oid);
    appointmentListNames.add(string);
  }
  }
  @override
  void onInit() async {
    await getFullList();
    super.onInit();
  }

}
