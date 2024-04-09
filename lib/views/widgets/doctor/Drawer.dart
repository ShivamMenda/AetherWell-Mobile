import 'package:aetherwell/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
class CustomDrawer extends StatelessWidget {

  CustomDrawer({Key? key}) : super(key: key);

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
              'Atherwell Doctor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              //Navigator.pop(context); // Close the drawer
              // Navigate to Home screen
              Get.offAndToNamed(AppRoutes.doctorHome);
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt_outlined),
            title: Text('Patient\'s Details'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to Patient's Details screen
            },
          ),
          ListTile(
            leading: Icon(Icons.date_range_outlined),
            title: Text('Appointment'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to Appointment screen
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              //Navigator.pop(context); // Close the drawer
              // Navigate to Profile screen
              Get.offAndToNamed(AppRoutes.doctorProfile);
            },
          ),
        ],
      ),
    );
  }
}
