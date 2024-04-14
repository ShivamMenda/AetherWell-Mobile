import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ListOfDoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of doctors'),
      ),
      body: Center(
        child: Text(
          'Welcome to List of doctors screen!',
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }
}
