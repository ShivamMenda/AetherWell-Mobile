import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:aetherwell/controllers/user/user_profile_controller.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final AuthController authController = Get.find<AuthController>();
  final UserProfileController userProfileController =
      Get.find<UserProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
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
              authController.logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => userProfileController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 3.h),
                      Text(
                        "Personal Information",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 3.h),
                      const CircleAvatar(
                        // backgroundImage: AssetImage(
                        //     "assets/images/doctor_profile.jpeg"), // Replace the URL with any image URL
                        radius: 50,
                        backgroundColor: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 3.w,
                        height: 2.h,
                      ),
                      _buildTextFormField(
                          userProfileController.name, "Name", Icons.person),
                      SizedBox(height: 1.h),
                      _buildTextFormField(
                          userProfileController.email, "Email", Icons.email),
                      SizedBox(height: 1.h),
                      _buildTextFormField(
                          userProfileController.phone, "Phone", Icons.phone),
                      SizedBox(height: 1.h),
                      _buildTextFormField(
                          userProfileController.name, "Gender", Icons.info),
                      SizedBox(height: 1.h),
                      _buildTextFormField(
                          userProfileController.address, "Address", Icons.home),
                    ],
                  )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          Get.bottomSheet(
            SingleChildScrollView(child: _buildBottomSheet()),
            backgroundColor: Get.theme.colorScheme.secondaryContainer,
          );
        },
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      style: TextStyle(color: Colors.white70, fontSize: 10.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 14.sp),
        prefixIcon: Icon(icon, color: Colors.white70),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Edit Your Profile Here",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          _buildTextField(userProfileController.email, "Email", Icons.email),
          SizedBox(height: 1.h),
          _buildTextField(userProfileController.phone, "Phone", Icons.phone),
          SizedBox(height: 1.h),
          _buildTextField(userProfileController.gender, "Gender", Icons.info),
          SizedBox(height: 1.h),
          _buildTextField(userProfileController.address, "Address", Icons.home),
          SizedBox(height: 3.h),
          MaterialButton(
            onPressed: () {
              userProfileController.updateProfile();
            },
            child: Text("Update Now"),
            color: Colors.blueAccent,
            minWidth: Get.width * 0.5,
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
