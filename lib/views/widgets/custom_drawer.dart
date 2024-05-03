import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:aetherwell/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

final AuthController authController = Get.find<AuthController>();

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(
              authController.isUser.value == true
                  ? "AetherWell User"
                  : 'Aetherwell Doctor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              authController.isUser.value == true
                  ? Get.offAndToNamed(AppRoutes.userHome)
                  : Get.offAndToNamed(AppRoutes.doctorHome);
            },
          ),
          ListTile(
            leading: authController.isUser.value == true
                ? Icon(Icons.recommend)
                : Icon(Icons.receipt_outlined),
            title: authController.isUser.value == true
                ? Text("Recommendations")
                : Text('Patient\'s Details'),
            onTap: () {
              authController.isUser.value == true
                  ? Get.offAllNamed(AppRoutes.userRecommendation)
                  : Get.offAllNamed(AppRoutes.patientDetails);
            },
          ),
          ListTile(
            leading: Icon(Icons.date_range_outlined),
            title: Text('Appointments'),
            onTap: () {
              authController.isUser.value == true
                  ? Get.offAllNamed(AppRoutes.userAppointments)
                  : Get.offAllNamed(AppRoutes.doctorAppointments);
              // Navigate to Appointment screen
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              authController.isUser.value == true
                  ? Get.offAndToNamed(AppRoutes.userProfile)
                  : Get.offAndToNamed(AppRoutes.doctorProfile);
            },
          ),
        ],
      ),
    );
  }
}
