import 'package:aetherwell/controllers/user/user_listofdoctors_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ListOfDoctorsScreen extends StatefulWidget {
  const ListOfDoctorsScreen({Key? key}) : super(key: key);

  @override
  State<ListOfDoctorsScreen> createState() => _ListOfDoctorsScreenState();
}

class _ListOfDoctorsScreenState extends State<ListOfDoctorsScreen> {
  final listOfDoctorsController=Get.put(ListOfDoctorsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Choose Your Doctor",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("Select Your Preffered Doctor",style: TextStyle(color: Colors.blueGrey,fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context,int index){
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 2,
                    color: Colors.blueAccent.withOpacity(0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.schedule, color: Colors.white70),
                              SizedBox(width: 10),
                              Text(
                                "Here's Your Appointment Details",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            leading: Icon(
                              Icons.today,
                              color: Colors.white70,
                            ),
                            title: Text(
                              "Number of Appointments Today: $dailyAppointments",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.calendar_view_week,
                              color: Colors.white70,
                            ),
                            title: Text(
                              "Number of Appointments for the Week: $weeklyAppointments",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Doctor Information:",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Name: Doctor Name",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Email: doctor@example.com",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Phone No: +1234567890",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );


                },
                itemCount: listOfDoctorsController.appointmentList.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}

