import 'package:get/get.dart';

class DoctorPatientController extends GetxController {
  List<Map<String, String>> patientList = [
    {
      'patientId': '001',
      'patientName': 'John Doe',
      'age': '35',
      'contactNumber': '+1234567890',
      'pastAppointments': '3',
      'nextAppointmentDate': '2024-04-10',
    },
    {
      'patientId': '002',
      'patientName': 'Jane Smith',
      'age': '28',
      'contactNumber': '+1987654321',
      'pastAppointments': '5',
      'nextAppointmentDate': '2024-04-12',
    },
    {
      'patientId': '003',
      'patientName': 'David Johnson',
      'age': '42',
      'contactNumber': '+1122334455',
      'pastAppointments': '2',
      'nextAppointmentDate': '2024-04-15',
    },
    {
      'patientId': '004',
      'patientName': 'Emily Brown',
      'age': '55',
      'contactNumber': '+1432567890',
      'pastAppointments': '4',
      'nextAppointmentDate': '2024-04-18',
    },
    {
      'patientId': '005',
      'patientName': 'Michael Williams',
      'age': '40',
      'contactNumber': '+1654321987',
      'pastAppointments': '6',
      'nextAppointmentDate': '2024-04-20',
    },
  ];

}