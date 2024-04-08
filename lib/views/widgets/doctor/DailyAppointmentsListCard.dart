import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final Map<String, String> appointmentDetails;
  final Color tileColor;
  final VoidCallback onViewDetails;

  AppointmentCard({
    required this.appointmentDetails,
    required this.tileColor,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        color: tileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Patient Name: ${appointmentDetails['patientName']}",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Diagnostics: ${appointmentDetails['diagnostics']}",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Gender: ${appointmentDetails['gender']}",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: onViewDetails,
                child: Text(
                  "View More Details",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
