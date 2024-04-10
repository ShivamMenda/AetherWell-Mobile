import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_routes.dart';

class DoctorAppointmentScreen extends StatelessWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
        title: Text('Doctor Appointment'),
      ),
      body: Center(
        child: Text(
          'Welcome to Doctor Appointment screen',
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Get.toNamed(AppRoutes.doctorAvailbitiyManagement);
        },
        child: Icon(Icons.analytics,color: Colors.white70,),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
