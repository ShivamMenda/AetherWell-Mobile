import 'package:aetherwell/controllers/user/user_appointment_controller.dart';
import 'package:get/get.dart';

class UserAppointmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserAppointmentsController());
  }
}
