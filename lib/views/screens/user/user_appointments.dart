import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Appointments'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text(
          'Welcome to User Appointment screen',
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }
}
