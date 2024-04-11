import 'package:get/get.dart';

class DoctorAppointmentController extends GetxController {
  List<Map<String, String>> appointmentList = [
    {
      'patientName': 'John Doe',
      'diagnostics': 'Fever',
      'gender': 'Male',
      'status':'confirmed',
    },
    {
      'patientName': 'Jane Smith',
      'diagnostics': 'Headache',
      'gender': 'Female',
      'status':'cancelled',
    },
    {
      'patientName': 'David Johnson',
      'diagnostics': 'Sore throat',
      'gender': 'Male',
      'status':'confirmed',
    },
    {
      'patientName': 'Emily Brown',
      'diagnostics': 'Cough',
      'gender': 'Female',
      'status':'confirmed',
    },
    {
      'patientName': 'Michael Williams',
      'diagnostics': 'Fatigue',
      'gender': 'Male',
      'status':'confirmed',
    },
  ];
}
