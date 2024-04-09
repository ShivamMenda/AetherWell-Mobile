import 'package:aetherwell/controllers/auth_controller.dart';
import 'package:aetherwell/views/widgets/doctor/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/doctor/BottomNavigation.dart';
import '../../widgets/doctor/DailyAppointmentsListCard.dart';
import '../../widgets/doctor/DailyAppointmentsMainCard.dart';

class DoctorHomeScreen extends StatefulWidget {
  DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  TextEditingController searchController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  int _currentIndex = 0;

  // Dummy List Replace By original List
  List<Map<String, String>> appointmentList = [
    {
      'patientName': 'John Doe',
      'diagnostics': 'Fever',
      'gender': 'Male',
    },
    {
      'patientName': 'Jane Smith',
      'diagnostics': 'Headache',
      'gender': 'Female',
    },
    {
      'patientName': 'David Johnson',
      'diagnostics': 'Sore throat',
      'gender': 'Male',
    },
    {
      'patientName': 'Emily Brown',
      'diagnostics': 'Cough',
      'gender': 'Female',
    },
    {
      'patientName': 'Michael Williams',
      'diagnostics': 'Fatigue',
      'gender': 'Male',
    },
  ];

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              //Search Bar
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueAccent.withOpacity(0.1),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search Appointments",
                    hintStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.normal,
                    ),
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: Colors.blueAccent,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              //Appointment Details Card
              AppointmentDetailsCard(
                dailyAppointments: 15, // Replace with your actual value from Api Calls
                weeklyAppointments: 45, // Replace with your actual value from Api Calls
              ),
              SizedBox(height: 20),
              Text(
                "Here's Your Day's Appointment's",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              //List View
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: appointmentList.length,
                itemBuilder: (BuildContext context, int index) {

                  Color? tileColor =Colors.blueAccent.withOpacity(0.05);

                  return AppointmentCard(
                    appointmentDetails: appointmentList[index],
                    tileColor: tileColor,
                    onViewDetails: () {
                      // Handle viewing more details
                    },
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


