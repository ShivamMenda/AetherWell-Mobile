import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PatientRecordTile extends StatelessWidget {
  final String? patientId;
  final String? patientName;
  final String? age;
  final String? contactNumber;
  final String? gender;
  final String? email;
  final Color borderColor;
  final Color textColor;

  const PatientRecordTile({
    Key? key,
    required this.patientId,
    required this.patientName,
    required this.age,
    required this.contactNumber,
    required this.gender,
    required this.email,
    required this.borderColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Random photo URL placeholder
    String randomPhotoUrl = 'https://media.istockphoto.com/id/825083568/photo/proud-latin-man.webp?b=1&s=170667a&w=0&k=20&c=CyG-7qRsTApt2se9eMhc-iPBHMj5Yj-ISytCWd3uZzQ=';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.blueGrey.withOpacity(0.1), // Adjust opacity as needed
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(-2, 0),
            ),
          ],
          border: Border(
            left: BorderSide(
              color: borderColor,
              width: 1.5.w, // Increased border width
            ),
          ),
        ),
        height: Get.height / 4,
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
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Patient ID: $patientId",
                            style: TextStyle(
                                color: textColor, fontWeight: FontWeight.bold)),
                        SizedBox(height: 1.h),
                        Text("Patient Name: $patientName",
                            style: TextStyle(
                                color: textColor, fontWeight: FontWeight.bold)),
                        SizedBox(height: 1.h),
                        Text("Age: $age",
                            style: TextStyle(
                                color: textColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Text("Contact Number: $contactNumber",
                  style: TextStyle(color: textColor)),
              SizedBox(height: 0.7.h),
              Text("Past Appointments: $gender",
                  style: TextStyle(color: textColor)),
              SizedBox(height: 0.7.h),
              Text("Next Appointment Date: $email",
                  style: TextStyle(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
