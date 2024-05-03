import 'package:aetherwell/controllers/doctor/patient_details.dart';
import 'package:get/get.dart';

class DoctorPatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DoctorPatientController());
  }
}