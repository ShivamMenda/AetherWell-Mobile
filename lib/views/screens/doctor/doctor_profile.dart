import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../widgets/doctor/drawer.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController specialization = TextEditingController();
  final TextEditingController clinic = TextEditingController();
  final TextEditingController experience = TextEditingController();

  bool showBottomSheet = false;

  @override
  void initState() {
    super.initState();
    // Replace hardcoded values with actual values fetched from the API
    name.text = "Doctor Name";
    email.text = "Doctor Email";
    phone.text = "Phone Number";
    specialization.text = "Cardiology";
    clinic.text = "Clinic Name / Hospital Name";
    experience.text = "2";
  }

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
              authController.logout();
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
                  style: TextStyle(color: Colors.blueGrey, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://media.istockphoto.com/id/177373093/photo/indian-male-doctor.jpg?s=612x612&w=0&k=20&c=5FkfKdCYERkAg65cQtdqeO_D0JMv6vrEdPw3mX1Lkfg='), // Replace the URL with any image URL
                      radius: 50,
                      backgroundColor: Colors.blueAccent,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextFormField(name, "Name", Icons.person),
                          _buildTextFormField(email, "Email", Icons.email),
                        ],
                      ),
                    ),
                  ],
                ),
                _buildTextFormField(phone, "Phone", Icons.phone),
                SizedBox(height: 10),
                _buildTextFormField(experience, "About me",Icons.text_rotation_angledown_sharp),
                SizedBox(height: 30),
                Text(
                  "Professional Information",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                _buildTextFormField(specialization, "Specialization", Icons.category),
                SizedBox(height: 10),
                _buildTextFormField(clinic, "Clinic / Hospital", Icons.local_hospital),
                SizedBox(height: 10),
                _buildTextFormField(experience, "Experience (Years)", Icons.timer),

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

  Widget _buildTextFormField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      style: TextStyle(color: Colors.white70,fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70,fontSize: 18),
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
          Text("Edit Your Profile Here",style: TextStyle(color: Colors.blueGrey,fontSize: 22,fontWeight: FontWeight.bold),),
          _buildTextField(email, "Email", Icons.email),
          _buildTextField(phone, "Phone", Icons.phone),
          _buildTextField(specialization, "Specialization", Icons.category),
          _buildTextField(clinic, "Clinic / Hospital", Icons.local_hospital),
          _buildTextField(experience, "Experience (Years)", Icons.timer),
          SizedBox(height: 16),
          MaterialButton(
            onPressed: (){},
            child: Text("Update Now"),
            color: Colors.blueAccent,
            minWidth: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        labelStyle: TextStyle(color: Colors.white70),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
      ),
      style: TextStyle(color: Colors.white70),
    );
  }
}


