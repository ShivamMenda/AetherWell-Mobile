//import mongo db package for object id
import 'package:mongo_dart/mongo_dart.dart';

//Appointment model
//Defining an enum for status
enum Status { pending, confirmed, canceled, attended }

//Pasring the enum to an string
extension ParseToString on Status {
  String toShortString() {
    return toString().split('.').last;
  }
}

// function to get the role
Status getStatus(String s) {
  if (s == "pending") {
    return Status.pending;
  } else if (s == "confirmed") {
    return Status.confirmed;
  } else if (s == "canceled") {
    return Status.canceled;
  }
  return Status.attended;
}

class Appointment {
  late ObjectId id;
  late Map<String, dynamic> doctorId;
  late Map<String, dynamic> userId;
  late DateTime date;
  late String startTime;
  late String endTime;
  late Status status;

  //Appointment constructor
  Appointment({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  //Factory mapper from Json to User model
  factory Appointment.fromJSON(Map<String, dynamic> json) {
    return Appointment(
      id: ObjectId.parse(json['_id'] as String),
      doctorId: json['doctorId'] as Map<String, dynamic>,
      userId: json['userId'] as Map<String, dynamic>,
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: getStatus(json['status']),
    );
  }

  //Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id.oid,
      'doctorId': doctorId,
      'userId': userId,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'status': status.toShortString(),
    };
  }
}
