import 'package:aetherwell/models/appointments.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserHomeController extends GetxController {
  List<Appointment> appointmentList = [
    // Get only today's appointments from API by date
    Appointment(
      id: ObjectId(),
      doctorId: ObjectId(),
      userId: ObjectId(),
      date: DateTime.now(),
      startTime: '10:00 AM',
      endTime: '11:00 AM',
      status: Status.confirmed,
    ),
    Appointment(
      id: ObjectId(),
      doctorId: ObjectId(),
      userId: ObjectId(),
      date: DateTime.now(),
      startTime: '11:00 AM',
      endTime: '12:00 PM',
      status: Status.pending,
    ),
    Appointment(
      id: ObjectId(),
      doctorId: ObjectId(),
      userId: ObjectId(),
      date: DateTime.now(),
      startTime: '12:00 PM',
      endTime: '1:00 PM',
      status: Status.attended,
    ),
  ];
}
