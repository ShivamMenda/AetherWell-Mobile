import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:aetherwell/controllers/user/home_controller.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:aetherwell/views/widgets/user/user_record_tile.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});
  final AuthController authController = Get.find<AuthController>();
  final UserHomeController userHomeController = Get.find<UserHomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Dashboard'),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome, ${authController.user.name}!',
                style: TextStyle(fontSize: 20.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.h),
              Text(
                "Today's Appointments",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.h),
              Obx(() => userHomeController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : userHomeController.appointmentList.isEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                              child: Text(
                                "No Appointments found for Today!",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userHomeController.appointmentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final dateTitle = DateFormat.yMMMd().format(
                              userHomeController.appointmentList[index].date,
                            );
                            final startTime = userHomeController
                                .appointmentList[index].startTime;
                            final doctorName = userHomeController
                                .appointmentList[index].doctorName;

                            return UserRecordTile(
                              dateTitle: dateTitle,
                              hospitalName: userHomeController
                                  .appointmentList[index].hospitalName,
                              doctorName: doctorName,
                              startTime: startTime,
                              onViewDetails: () {},
                            );
                          },
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
