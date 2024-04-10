import 'package:get/get.dart';

class UserHomeController extends GetxController {
  List<Map<String, String>> appointmentList = [ // Get only today's appointments from API by date
    {
      'date': '18-04-2023',
      'diseaseName': 'Fever',
      'doctorName': 'John Doe',
      'hospitalName': 'XYZ Hospital',
    },
    {
      'date': '19-04-2023',
      'diseaseName': 'Headache',
      'doctorName': 'Jane Smith',
      'hospitalName': 'ABC Hospital',
    },
    {
      'date': '20-04-2023',
      'diseaseName': 'Sore throat',
      'doctorName': 'David Johnson',
      'hospitalName': 'PQR Hospital',
    },
    {
      'date': '21-04-2023',
      'diseaseName': 'Cough',
      'doctorName': 'Emily Brown',
      'hospitalName': 'LMN Hospital',
    },
    {
      'date': '22-04-2023',
      'diseaseName': 'Fatigue',
      'doctorName': 'Michael Williams',
      'hospitalName': 'OPQ Hospital',
    }
  ];
}
