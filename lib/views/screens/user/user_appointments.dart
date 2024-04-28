import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:aetherwell/controllers/user/user_appointment_controller.dart';
import 'package:aetherwell/models/appointments.dart';
import 'package:aetherwell/routes/app_routes.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        title: const Text('User Appointments'),
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
              Obx(() => userAppointmentsController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          userAppointmentsController.appointmentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),

                            // A pane can dismiss the Slidable.
                            dragDismissible: true,

                            // All actions are defined in the children parameter.
                            children: [
                              // A SlidableAction can have an icon and/or a label.

                              SlidableAction(
                                onPressed: (context) {
                                  if (userAppointmentsController
                                          .appointmentList[index].status ==
                                      Status.confirmed) {
                                    userAppointmentsController
                                        .cancelAppointment(index);
                                  }
                                },
                                backgroundColor: userAppointmentsController
                                            .appointmentList[index].status ==
                                        Status.confirmed
                                    ? Colors.redAccent
                                    : Colors.green,
                                foregroundColor: Colors.white,
                                icon: userAppointmentsController
                                            .appointmentList[index].status ==
                                        Status.confirmed
                                    ? Icons.delete
                                    : Icons.restart_alt,
                                label: userAppointmentsController
                                            .appointmentList[index].status ==
                                        Status.confirmed
                                    ? "Cancel"
                                    : "Re-Book",
                              ),
                            ],
                          ),
                          child: SizedBox(
                            height: Get.height / 4.8,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15), // Add border radius
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // First Column
                                  Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(15)),
                                        color: Colors.blueAccent),
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.date_range_outlined,
                                            color: Colors.white70),
                                        SizedBox(height: 2.h),
                                        const Text(
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
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Doctor Name",
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            userAppointmentsController
                                                .appointmentList[index]
                                                .doctorName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "Hospital Name",
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            userAppointmentsController
                                                .appointmentList[index]
                                                .hospitalName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Third Column depending on status
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width:
                                          60, // Fixed width for both containers
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center, // Align text to center horizontally
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white70,
                                            size: 36,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "More\nDetails",
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.listOfDoctors);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
