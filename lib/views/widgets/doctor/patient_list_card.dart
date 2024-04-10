import 'package:flutter/material.dart';

class PatientRecordTile extends StatelessWidget {
  final String? patientId;
  final String? patientName;
  final String? age;
  final String? contactNumber;
  final String? pastAppointments;
  final String? nextAppointmentDate;
  final Color borderColor;
  final Color textColor;

  const PatientRecordTile({
    Key? key,
    required this.patientId,
    required this.patientName,
    required this.age,
    required this.contactNumber,
    required this.pastAppointments,
    required this.nextAppointmentDate,
    required this.borderColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Random photo URL placeholder
    String randomPhotoUrl = 'https://source.unsplash.com/200x200/?person';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.1), // Adjust opacity as needed
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(-2, 0),
            ),
          ],
          border: Border(
            left: BorderSide(
              color: borderColor,
              width: 3, // Increased border width
            ),
          ),
        ),
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(randomPhotoUrl),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Patient ID: $patientId", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("Patient Name: $patientName", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("Age: $age", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text("Contact Number: $contactNumber", style: TextStyle(color: textColor)),
              SizedBox(height: 5),
              Text("Past Appointments: $pastAppointments", style: TextStyle(color: textColor)),
              SizedBox(height: 5),
              Text("Next Appointment Date: $nextAppointmentDate", style: TextStyle(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}

