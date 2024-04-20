import 'package:get/get.dart';
import 'package:aetherwell/models/doctorappointments.dart';
class DoctorHomeController extends GetxController {


  List<Map<String, String>> appointmentList = [
    {
      'patientName': 'John Doe',
      'diagnostics': 'Fever',
      'gender': 'Male',
    },
    {
      'patientName': 'Jane Smith',
      'diagnostics': 'Headache',
      'gender': 'Female',
    },
    {
      'patientName': 'David Johnson',
      'diagnostics': 'Sore throat',
      'gender': 'Male',
    },
    {
      'patientName': 'Emily Brown',
      'diagnostics': 'Cough',
      'gender': 'Female',
    },
    {
      'patientName': 'Michael Williams',
      'diagnostics': 'Fatigue',
      'gender': 'Male',
    },
  ];
}
