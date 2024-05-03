import 'package:flutter/material.dart';

class AppointmentDetailsCard extends StatelessWidget {
  final int dailyAppointments;
  final int totalAppointments;

  AppointmentDetailsCard({
    required this.dailyAppointments,
    required this.totalAppointments,
  });

  @override
  Widget build(BuildContext context) {
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
                  "Number of Appointments in Total: $totalAppointments",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
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
