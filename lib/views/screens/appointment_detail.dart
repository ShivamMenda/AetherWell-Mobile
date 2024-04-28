import 'package:aetherwell/controllers/user/appointment_detail.dart';
import 'package:aetherwell/controllers/doctor/doctor_appointment_detail.dart';
import 'package:aetherwell/routes/app_routes.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentDetails extends StatefulWidget {
  final String appointmentId;
  final String startTime;
  final String endTime;
  final String status;
  final String date;
  final String patientName;
  final String doctorName;
  final String doctorId;
  const AppointmentDetails({
    Key? key,
    required this.appointmentId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.date,
    required this.patientName,
    required this.doctorName,
    required this.doctorId,
  }) : super(key: key);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  final appointmentDetailController = Get.put(AppointmentDetailController());
  final DoctorAppointmentDetailController doctorAppointmentDetailController =
      Get.put(DoctorAppointmentDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://t3.ftcdn.net/jpg/02/60/79/68/360_F_260796882_QyjDubhDDk0RZXV9z7XBEw9AKnWCizXy.jpg"),
                      radius: 80,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildInfoRow('Appointment ID:', widget.appointmentId),
                  _buildInfoRow('Patient Name:', widget.patientName),
                  _buildInfoRow('Doctor Name:', widget.doctorName),
                  _buildInfoRow('Date:', widget.date),
                  _buildInfoRow('Start Time:', widget.startTime),
                  _buildInfoRow('End Time:', widget.endTime),
                  _buildInfoRow('Status:', widget.status),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: TextButton(
                          onPressed: () async {
                            authController.isUser.value == true
                                ? await appointmentDetailController
                                    .cancelAppointment(
                                        widget.appointmentId, widget.doctorId)
                                : await doctorAppointmentDetailController
                                    .cancelAppointment(widget.appointmentId);
                            authController.isUser.value == true
                                ? Get.offAllNamed(AppRoutes.userHome)
                                : Get.offAllNamed(AppRoutes.doctorHome);
                          },
                          child: Text(
                            "Cancel Appointment",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5), // Space between label and value
          Text(
            value,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
