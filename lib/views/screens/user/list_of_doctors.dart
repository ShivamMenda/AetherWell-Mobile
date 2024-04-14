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
  final listOfDoctorsController = Get.put(ListOfDoctorsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Choose Your Doctor",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Select Your Preffered Doctor",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => listOfDoctorsController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listOfDoctorsController.doctorsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.blueGrey,
                                            backgroundImage: NetworkImage(
                                              "https://source.unsplash.com/featured/?doctor",
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                listOfDoctorsController
                                                    .doctorsList[index].name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                listOfDoctorsController
                                                    .doctorsList[index]
                                                    .hospital,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                listOfDoctorsController
                                                    .doctorsList[index].email,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                ),
                                                softWrap: true,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                listOfDoctorsController
                                                    .doctorsList[index]
                                                    .specialization,
                                                style: const TextStyle(
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
                                              builder: (context) =>
                                                  AppointmentBookingScreen(
                                                doctor: listOfDoctorsController
                                                    .doctorsList[index],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
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
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
