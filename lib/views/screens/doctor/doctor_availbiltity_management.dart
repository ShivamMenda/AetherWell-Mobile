import 'package:aetherwell/controllers/doctor/availbility_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/doctor/analytics_card_patientand_appointments.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: unused_import
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DoctorAvailbilityManagement extends StatefulWidget {
  const DoctorAvailbilityManagement({Key? key}) : super(key: key);

  @override
  State<DoctorAvailbilityManagement> createState() =>
      _DoctorAvailbilityManagementState();
}

class _DoctorAvailbilityManagementState
    extends State<DoctorAvailbilityManagement> {
  final doctorAvailbilityController = Get.put(DoctorAvailbilityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Analytics'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                "Here's Your Analytics",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: Get.height / 4.5, // Set the height of the GridView
                child: GridView.count(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  crossAxisCount: 1,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(), // Allow scrolling
                  children: [
                    CustomCardWidget(
                      icon: Icons.people,
                      header: 'Patients',
                      subheader: doctorAvailbilityController.patientNumber,
                      iconColor: Colors.white70,
                    ),
                    CustomCardWidget(
                      icon: Icons.calendar_today,
                      header: 'Appointments',
                      subheader: doctorAvailbilityController.appointmentsNumber,
                      iconColor: Colors.white70,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Patient Visit Satisfaction",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Container(
                height: 350, // Adjust the height as needed
                child: SfCircularChart(
                  palette: [Colors.blueAccent, Colors.blueGrey, Colors.white70],
                  legend: Legend(
                      isVisible: true,
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  series: <CircularSeries>[
                    DoughnutSeries<PieChartData, String>(
                      dataSource: doctorAvailbilityController.piChartData,
                      xValueMapper: (PieChartData data, _) => data.category,
                      yValueMapper: (PieChartData data, _) => data.value,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Patient's Inflow Over the week",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              Container(
                  child: SfCartesianChart(
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),

                      // Add legend
                      legend: Legend(
                        isVisible: true,
                        textStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                        ),
                      ),
                      series: <LineSeries<InflowData, String>>[
                    LineSeries<InflowData, String>(
                      name: 'Inflow Analysis', // Add series label
                      dataSource: doctorAvailbilityController.inflowData,
                      xValueMapper: (InflowData data, _) => data.day,
                      yValueMapper: (InflowData data, _) => data.number,
                      color: Colors.blueAccent,
                      animationDelay: 2000,
                      animationDuration: 1500,
                    )
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
