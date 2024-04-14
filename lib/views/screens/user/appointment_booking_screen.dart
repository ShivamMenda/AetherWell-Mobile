import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppointmentBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Booking'),
      ),
      body: Center(
        child: Text(
          'Welcome to Appointment Booking screen!',
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }
}
