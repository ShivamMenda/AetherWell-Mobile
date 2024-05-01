import 'package:aetherwell/controllers/doctor/appointment.dart';
import 'package:aetherwell/views/screens/appointment_detail.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_routes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  final doctorAppointmentController = Get.find<DoctorAppointmentController>();
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
        title: Text('Doctor Appointments'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Here Are All Your Appointments",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => doctorAppointmentController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : doctorAppointmentController.appointmentList.isNotEmpty
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: doctorAppointmentController
                                .appointmentList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => AppointmentDetails(
                                      appointmentId: doctorAppointmentController
                                          .appointmentList[index].id.oid,
                                      startTime: doctorAppointmentController
                                          .appointmentList[index].startTime,
                                      endTime: doctorAppointmentController
                                          .appointmentList[index].endTime,
                                      status: doctorAppointmentController
                                          .appointmentList[index].status.name,
                                      date: doctorAppointmentController
                                          .appointmentList[index].date
                                          .toIso8601String()
                                          .substring(0, 10),
                                      patientName: doctorAppointmentController
                                          .appointmentList[index]
                                          .userId['name'],
                                      doctorName: doctorAppointmentController
                                          .appointmentList[index]
                                          .doctorId['name'],
                                      doctorId: doctorAppointmentController
                                          .appointmentList[index]
                                          .doctorId['_id'],
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
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
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(15)),
                                              color: Colors.blueAccent),
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.date_range_outlined,
                                                  color: Colors.white70),
                                              SizedBox(height: 8),
                                              Text(
                                                doctorAppointmentController
                                                    .appointmentList[index].date
                                                    .toIso8601String()
                                                    .substring(0, 10),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  doctorAppointmentController
                                                          .appointmentListNames[
                                                      index],
                                                  style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  "Start Time",
                                                  style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  doctorAppointmentController
                                                      .appointmentList[index]
                                                      .startTime,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  "End Time",
                                                  style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  doctorAppointmentController
                                                      .appointmentList[index]
                                                      .endTime,
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
                                          width:
                                              60, // Fixed width for both containers
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(15),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(8),
                                          child: Column(
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
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Center(
                                child: Text(
                                  "No Appointments found!",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                            ],
                          )),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.doctorAvailbitiyManagement);
        },
        child: Icon(
          Icons.analytics,
          color: Colors.white70,
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
