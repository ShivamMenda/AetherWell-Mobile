import 'package:aetherwell/controllers/user/user_listofdoctors_controller.dart';
import 'package:aetherwell/views/screens/user/appointment_booking_screen.dart';
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
              Text("Select Your Preffered Doctor",style: TextStyle(color: Colors.white70,fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){},
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.blueAccent.withOpacity(0.05),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blueGrey,
                                    backgroundImage: NetworkImage(
                                      "https://source.unsplash.com/featured/?doctor",
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${listOfDoctorsController.DoctorsList[index].name}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "${listOfDoctorsController.DoctorsList[index].hospital}",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "${listOfDoctorsController.DoctorsList[index].email}",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "${listOfDoctorsController.DoctorsList[index].specialization}",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AppointmentBookingScreen(
                                        doctor: listOfDoctorsController.DoctorsList[index],
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );




                },
                itemCount: listOfDoctorsController.DoctorsList.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}

