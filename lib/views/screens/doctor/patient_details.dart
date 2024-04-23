import 'package:aetherwell/controllers/doctor/patient_details.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:aetherwell/views/widgets/doctor/patient_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final doctorPatientController = Get.put(DoctorPatientController());

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
        title: Text('Patient Details'),
      ),
      body: Obx(
        ()=>doctorPatientController.isLoading.value?
            Center(
              child: CircularProgressIndicator(),
            )
            : SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Check Your Patient's Details",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: doctorPatientController.patientList.length,
                itemBuilder: (BuildContext context, int index) {
                  // ignore: unused_local_variable
                  Color? tileColor = Colors.blueAccent.withOpacity(0.05);

                  return PatientRecordTile(
                    patientId: doctorPatientController.patientList[index].userId['_id'].toString(),
                    patientName: doctorPatientController.patientList[index].userId['name'],
                    age: doctorPatientController.patientList[index].userId['age'].toString(),
                    contactNumber: doctorPatientController.patientList[index].userId['phone'],
                    gender: doctorPatientController.patientList[index].userId['gender'],
                    email: doctorPatientController
                        .patientList[index].userId['email'],
                    borderColor: Colors.blueAccent,
                    textColor: Colors.white70,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
