import 'package:aetherwell/controllers/doctor/profile_controller.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
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
                const SizedBox(height: 20),
                const Text(
                  "Personal Information",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/images/doctor_profile.jpeg"), // Replace the URL with any image URL
                      radius: 50,
                      backgroundColor: Colors.blueAccent,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextFormField(doctorProfileController.name,
                              "Name", Icons.person),
                          _buildTextFormField(doctorProfileController.phone,
                              "Phone", Icons.phone),
                        ],
                      ),
                    ),
                  ],
                ),
                _buildTextFormField(
                    doctorProfileController.email, "Email", Icons.email),
                const SizedBox(height: 10),
                _buildTextFormField(doctorProfileController.aboutController,
                    "About me", Icons.text_rotation_angledown_sharp),
                const SizedBox(height: 30),
                const Text(
                  "Professional Information",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildTextFormField(doctorProfileController.specialization,
                    "Specialization", Icons.category),
                const SizedBox(height: 10),
                _buildTextFormField(doctorProfileController.clinic,
                    "Clinic / Hospital", Icons.local_hospital),
                const SizedBox(height: 10),
                _buildTextFormField(
                    doctorProfileController.gender, "Gender", Icons.timer),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blueAccent,
      //   child: const Icon(Icons.edit, color: Colors.white),
      //   onPressed: () {
      //     showModalBottomSheet(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return _buildBottomSheet();
      //       },
      //     );
      //   },
      // ),
      // bottomSheet: showBottomSheet ? _buildBottomSheet() : null,
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      style: const TextStyle(color: Colors.white70, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70, fontSize: 18),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
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
          const Text(
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
          _buildTextField(
              doctorProfileController.aboutController, "About me", Icons.timer),
          const SizedBox(height: 16),
          MaterialButton(
            onPressed: () {},
            child: const Text("Update Now"),
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
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
      ),
      style: const TextStyle(color: Colors.white70),
    );
  }
}
