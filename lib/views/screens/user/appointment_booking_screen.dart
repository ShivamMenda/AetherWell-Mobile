import 'package:aetherwell/controllers/user/user_appointmentbooking_controller.dart';
import 'package:aetherwell/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';

class AppointmentBookingScreen extends StatefulWidget {
  late Doctor? doctor;
  AppointmentBookingScreen({Key? key,required this.doctor}) : super(key: key);

  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final userAppointmentBookingController=Get.put(UserAppointmentBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text("Choose Day and Slot",style: TextStyle(color: Colors.white),),
      centerTitle: true,
    ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("Choose any Day",style: TextStyle(color: Colors.white70,fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              EasyInfiniteDateTimeLine(
                  showTimelineHeader: false,
                  dayProps: EasyDayProps(
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8.0), // Set border radius
                      ),
                      dayNumStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16),
                      dayStrStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14),
                      monthStrStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8.0), // Set border radius
                      ),
                      dayNumStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16),
                      dayStrStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14),
                      monthStrStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    todayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: userAppointmentBookingController.startTime == userAppointmentBookingController.focusDate ? Colors.blueAccent : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8.0), // Set border radius
                      ),
                      dayNumStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16),
                      dayStrStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14),
                      monthStrStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  controller: userAppointmentBookingController.controller,
                  firstDate: userAppointmentBookingController.startTime,
                  focusDate: userAppointmentBookingController.focusDate,
                  lastDate: userAppointmentBookingController.endTime,
                  onDateChange: (selectedDate) {
                    setState(() {
                      userAppointmentBookingController.changeDate(selectedDate);
                      userAppointmentBookingController.selectedIndex=0;
                    });
                  }
              ),
              SizedBox(height: 30,),
              Text("Available Slots",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 24),),
              SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CustomRadioButton(
                    horizontal: true,
                    buttonWidth: 110,
                    buttonHeight: 50,
                    selectedColor: Colors.blueAccent,
                    initialSelection: userAppointmentBookingController.selectedIndex,
                    radioButtonValue: (name,index){
                      setState(() {
                        userAppointmentBookingController.selectedIndex=index;
                      });
                    },buttonLables: ["7:00 AM","8:00 AM","9:00 AM","10:00 AM","11:00 AM",
                    "5:00 PM","6:00 PM","7:00 PM","8:00 PM"
                  ],
                    buttonValues: ["7:00 AM","8:00 AM","9:00 AM","10:00 AM","11:00 AM",
                      "5:00 PM","6:00 PM","7:00 PM","8:00 PM"
                    ],
                    buttonColor: Colors.blueGrey,
                    fontSize: 16,
                    textColor: Colors.white70,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Note by Clicking Confim you are aggreing to our T&C.Appointment Cancellation may be subjected to Doctor Availbility.",
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Note The Slot and the day you choose is final and cannot be changed.",
                ),
              ),
              SizedBox(height: 30,),
              FractionallySizedBox(
                widthFactor: 0.8, // Adjust the width factor as needed
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Confirm Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 20,),
              // FractionallySizedBox(
              //   widthFactor: 0.8, // Adjust the width factor as needed
              //   child: OutlinedButton(
              //     onPressed: () {},
              //     style: OutlinedButton.styleFrom(
              //       side: BorderSide(color: Colors.blueGrey),
              //       padding: EdgeInsets.symmetric(vertical: 14),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //     child: Text(
              //       "Choose any other doctor",
              //       style: TextStyle(
              //         color: Colors.blueGrey,
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}

