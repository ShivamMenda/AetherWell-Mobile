import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:aetherwell/controllers/user/user_appointment_controller.dart';
import 'package:aetherwell/routes/app_routes.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UserAppointmentScreen extends StatefulWidget {
  const UserAppointmentScreen({super.key});

  @override
  State<UserAppointmentScreen> createState() => _UserAppointmentScreenState();
}

class _UserAppointmentScreenState extends State<UserAppointmentScreen> {
  final AuthController authController = Get.find<AuthController>();
  final UserAppointmentsController userAppointmentsController =
      Get.find<UserAppointmentsController>();
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
        title: Text('User Appointments'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Here Are All \nYour Appointments,\n ${authController.user.name}!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userAppointmentsController.appointmentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: Get.height / 4.8,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Add border radius
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // First Column
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(15)),
                                  color: Colors.blueAccent),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.date_range_outlined,
                                      color: Colors.white70),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "20-04-2024",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Second Column
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Doctor Name",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userAppointmentsController
                                              .appointmentList[index]
                                          ['doctorName']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Symptoms",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userAppointmentsController
                                          .appointmentList[index]['symptoms']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Gender",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userAppointmentsController
                                                  .appointmentList[index]
                                              ['gender'] ??
                                          "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Third Column depending on status
                            Container(
                              width: 50, // Fixed width for both containers
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(15),
                                ),
                                color: userAppointmentsController
                                            .appointmentList[index]['status'] ==
                                        "confirmed"
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // Align text to center horizontally
                                children: [
                                  Icon(
                                    userAppointmentsController
                                                    .appointmentList[index]
                                                ['status'] ==
                                            "confirmed"
                                        ? Icons.cloud_done
                                        : Icons.delete,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(height: 0.5.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.listOfDoctors);
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
