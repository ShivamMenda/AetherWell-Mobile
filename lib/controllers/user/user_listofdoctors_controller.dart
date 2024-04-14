import 'package:get/get.dart';

import '../../models/doctor.dart';

class ListOfDoctorsController extends GetxController {
  List<Doctor> DoctorsList = [
    Doctor(
      username: 'john_doe',
      email: 'john_doe@example.com',
      role: DoctorRole.doctor,
      name: 'John Doe',
      age: 35,
      specialization: 'Cardiology',
      hospital: 'General Hospital',
      availability: [],
    ),
    Doctor(
      username: 'jane_smith',
      email: 'jane_smith@example.com',
      role: DoctorRole.doctor,
      name: 'Jane Smith',
      age: 42,
      specialization: 'Neurology',
      hospital: 'City Hospital',
      availability: [],
    ),
    Doctor(
      username: 'david_johnson',
      email: 'david_johnson@example.com',
      role:DoctorRole.doctor,
      name: 'David Johnson',
      age: 40,
      specialization: 'Dermatology',
      hospital: 'Metro Hospital',
      availability: [],
    ),
    Doctor(
      username: 'emily_brown',
      email: 'emily_brown@example.com',
      role: DoctorRole.doctor,
      name: 'Emily Brown',
      age: 38,
      specialization: 'Pediatrics',
      hospital: 'Children\'s Hospital',
      availability: [],
    ),
    Doctor(
      username: 'emily_brown',
      email: 'emily_brown@example.com',
      role: DoctorRole.doctor,
      name: 'Emily Brown',
      age: 38,
      specialization: 'Pediatrics',
      hospital: 'Children\'s Hospital',
      availability: [],
    ),
    Doctor(
      username: 'john_doe',
      email: 'john_doe@example.com',
      role: DoctorRole.doctor,
      name: 'John Doe',
      age: 35,
      specialization: 'Cardiology',
      hospital: 'General Hospital',
      availability: [],
    ),
  ];
}
