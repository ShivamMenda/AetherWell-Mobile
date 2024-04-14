import 'package:get/get.dart';

class ListOfDoctorsController extends GetxController {
  List<Map<String, String>> appointmentList = [
    {
      'doctorName': 'John Doe',
      'symptoms': 'Fever',
      'gender': 'Male',
      'status':'confirmed',
    },
    {
      'doctorName': 'Jane Smith',
      'symptoms': 'Headache',
      'gender': 'Female',
      'status':'cancelled',
    },
    {
      'doctorName': 'David Johnson',
      'symptoms': 'Sore throat',
      'gender': 'Male',
      'status':'confirmed',
    },
    {
      'doctorName': 'Emily Brown',
      'symptoms': 'Cough',
      'gender': 'Female',
      'status':'confirmed',
    },
    {
      'doctorName': 'Michael Williams',
      'symptoms': 'Fatigue',
      'gender': 'Male',
      'status':'confirmed',
    },
  ];
}
