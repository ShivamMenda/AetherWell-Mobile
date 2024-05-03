import 'package:aetherwell/bindings/appointment_detail_binding.dart';
import 'package:aetherwell/bindings/doctor/doctor_appointment.dart';
import 'package:aetherwell/bindings/doctor/doctor_home_binding.dart';
import 'package:aetherwell/bindings/doctor/doctor_profile_binding.dart';
import 'package:aetherwell/bindings/login_binding.dart';
import 'package:aetherwell/bindings/signup_binding.dart';
import 'package:aetherwell/bindings/splash_binding.dart';
import 'package:aetherwell/bindings/user/user_appointment_binding.dart';
import 'package:aetherwell/bindings/user/user_home_binding.dart';
import 'package:aetherwell/bindings/user/user_profile_binding.dart';
import 'package:aetherwell/bindings/user/user_recommendation_bindings.dart';
import 'package:aetherwell/controllers/user/user_recommendation_selection_controller.dart';
import 'package:aetherwell/views/screens/appointment_detail.dart';
import 'package:aetherwell/views/screens/doctor/doctor_appointment.dart';
import 'package:aetherwell/views/screens/doctor/doctor_availbiltity_management.dart';
import 'package:aetherwell/views/screens/doctor/doctor_profile.dart';
import 'package:aetherwell/views/screens/doctor/home_screen.dart';
import 'package:aetherwell/views/screens/doctor/patient_details.dart';
import 'package:aetherwell/views/screens/login_screen.dart';
import 'package:aetherwell/views/screens/signup_screen.dart';
import 'package:aetherwell/views/screens/user/appointment_booking_screen.dart';
import 'package:aetherwell/views/screens/user/list_of_doctors.dart';
import 'package:aetherwell/views/screens/user/profile_screen.dart';
import 'package:aetherwell/views/screens/user/user_appointments.dart';
import 'package:aetherwell/views/screens/user/user_recommendation_screen.dart';
import '../views/screens/user/user_recommendation_selection.dart';
import 'app_routes.dart';
import 'package:get/get.dart';
import 'package:aetherwell/views/screens/splash_screen.dart';
import 'package:aetherwell/views/screens/user/home_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.userHome,
      page: () => UserHomeScreen(),
      binding: UserHomeBinding(),
    ),
    GetPage(
      name: AppRoutes.doctorHome,
      page: () => DoctorHomeScreen(),
      binding: DoctorHomeBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignUpScreen(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.doctorProfile,
      page: () => DoctorProfile(),
      binding: DoctorProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.userProfile,
      page: () => UserProfileScreen(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.userRecommendation,
      page: () => UserRecommendationScreen(),
      binding: UserRecommendationBinding(),
    ),
    GetPage(
      name: AppRoutes.userAppointments,
      page: () => UserAppointmentScreen(),
      binding: UserAppointmentsBinding(),
    ),
    GetPage(
      name: AppRoutes.doctorAppointments,
      page: () => DoctorAppointmentScreen(),
      binding: DoctorAppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.patientDetails,
      page: () => PatientDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.doctorAvailbitiyManagement,
      page: () => DoctorAvailbilityManagement(),
    ),
    GetPage(
      name: AppRoutes.listOfDoctors,
      page: () => ListOfDoctorsScreen(),
    ),
    GetPage(
      name: AppRoutes.appointmentBooking,
      page: () => AppointmentBookingScreen(
        doctor: null,
      ),
    ),
    GetPage(name: AppRoutes.detailsForAppointments,
      page: ()=>AppointmentDetails(
        appointmentId: "NA",
        startTime: "NA",
        endTime: "NA",
        status: "NA",
        date: "NA",
        patientName: "NA",
        doctorName: "NA",
        doctorId: "NA",
      ),
      binding: AppointmentDetailBinding(),
    ),
    GetPage(name: AppRoutes.userRecommendationSelectionController,
        page: ()=>UserRecommendationSelection(
          diseasesPrediction: [],
        )),

  ];
}
