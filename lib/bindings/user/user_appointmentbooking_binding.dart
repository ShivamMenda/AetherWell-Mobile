import 'package:aetherwell/controllers/user/home_controller.dart';
import 'package:aetherwell/controllers/user/user_appointmentbooking_controller.dart';
import 'package:get/get.dart';
import 'package:aetherwell/controllers/auth_controller.dart';

class UserAppointmentBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserAppointmentBookingController>(
        UserAppointmentBookingController());
  }
}
