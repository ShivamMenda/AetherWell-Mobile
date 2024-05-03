//import mongo db package for object id type
import 'package:mongo_dart/mongo_dart.dart';
//UserAppointment model
class DoctorAppointment {

  //Defining the id's these are required fields
  late ObjectId doctorId;
  late ObjectId appointmentId;

  DoctorAppointment({
    required this.doctorId,
    required this.appointmentId
  });

  // Factory constructor to create a DoctorAppointment object from JSON data (map form json).
  factory DoctorAppointment.fromJson(Map<String, dynamic> json) {
    return DoctorAppointment(
      doctorId:ObjectId.parse(json['userId'] as String),
      appointmentId:ObjectId.parse(json['appointmentId'] as String),
    );
  }

  // Method to convert DoctorAppointment object to JSON (map to json)
  Map<String, dynamic> toJson() {
    return {
      'userId': doctorId.oid,
      'appointmentId': appointmentId.oid,
    };
  }
}