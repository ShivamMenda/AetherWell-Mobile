//import mongo db package for object id type
import 'package:mongo_dart/mongo_dart.dart';
//UserAppointment model
class UserAppointment {

  //Defining the id's these are required fields
  late ObjectId userId;
  late ObjectId appointmentId;

  UserAppointment({
    required this.userId,
    required this.appointmentId
  });

  // Factory constructor to create a UserAppointment object from JSON data (map form json).
  factory UserAppointment.fromJson(Map<String, dynamic> json) {
    return UserAppointment(
      userId:ObjectId.parse(json['userId'] as String),
      appointmentId:ObjectId.parse(json['appointmentId'] as String),
    );
  }

  // Method to convert UserAppointment object to JSON (map to json)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId.oid,
      'appointmentId': appointmentId.oid,
    };
  }
}