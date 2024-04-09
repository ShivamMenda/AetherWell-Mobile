import 'package:aetherwell/controllers/doctor/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/doctor/drawer.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final DoctorProfileController doctorProfileController =
      Get.find<DoctorProfileController>();

  bool showBottomSheet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Doctor'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              doctorProfileController.authController.logout();
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Personal Information",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/id/177373093/photo/indian-male-doctor.jpg?s=612x612&w=0&k=20&c=5FkfKdCYERkAg65cQtdqeO_D0JMv6vrEdPw3mX1Lkfg='), // Replace the URL with any image URL
                      radius: 50,
                      backgroundColor: Colors.blueAccent,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextFormField(doctorProfileController.name,
                              "Name", Icons.person),
                          _buildTextFormField(doctorProfileController.email,
                              "Email", Icons.email),
                        ],
                      ),
                    ),
                  ],
                ),
                _buildTextFormField(
                    doctorProfileController.phone, "Phone", Icons.phone),
                SizedBox(height: 10),
                _buildTextFormField(doctorProfileController.experience,
                    "About me", Icons.text_rotation_angledown_sharp),
                SizedBox(height: 30),
                Text(
                  "Professional Information",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                _buildTextFormField(doctorProfileController.specialization,
                    "Specialization", Icons.category),
                SizedBox(height: 10),
                _buildTextFormField(doctorProfileController.clinic,
                    "Clinic / Hospital", Icons.local_hospital),
                SizedBox(height: 10),
                _buildTextFormField(doctorProfileController.experience,
                    "Experience (Years)", Icons.timer),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _buildBottomSheet();
            },
          );
        },
      ),
      // bottomSheet: showBottomSheet ? _buildBottomSheet() : null,
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      style: TextStyle(color: Colors.white70, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 18),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        prefixIcon: Icon(icon, color: Colors.white70),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Edit Your Profile Here",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          _buildTextField(doctorProfileController.email, "Email", Icons.email),
          _buildTextField(doctorProfileController.phone, "Phone", Icons.phone),
          _buildTextField(doctorProfileController.specialization,
              "Specialization", Icons.category),
          _buildTextField(doctorProfileController.clinic, "Clinic / Hospital",
              Icons.local_hospital),
          _buildTextField(doctorProfileController.experience,
              "Experience (Years)", Icons.timer),
          SizedBox(height: 16),
          MaterialButton(
            onPressed: () {},
            child: Text("Update Now"),
            color: Colors.blueAccent,
            minWidth: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        labelStyle: TextStyle(color: Colors.white70),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
      ),
      style: TextStyle(color: Colors.white70),
    );
  }
}
