//import mongo db package for object id
import 'package:mongo_dart/mongo_dart.dart';
//Appointment model
//Defining an enum for status
enum Status{
  pending,
  confirmed,
  canceled,
  attended
}
//Pasring the enum to an string
extension ParseToString on Status{
  String toShortString() {
    return toString().split('.').last;
  }
}
// function to get the role
Status getStatus(String s){
  if(s=="pending"){
    return Status.pending;
  }else if(s=="confirmed"){
    return Status.confirmed;
  }else if(s=="canceled"){
    return Status.canceled;
  }
  return Status.attended;
}

class Appointment{
    late ObjectId doctorId;
    late ObjectId userId;
    late DateTime date;
    late String startTime;
    late String endTime;
    late Status status;

    //Appointment constructor
    Appointment({
    required this.doctorId,
    required this.userId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    });

    //Factory mapper from Json to User model
    factory Appointment.fromJSON(Map<String,dynamic>json){
      return Appointment(
        doctorId: ObjectId.parse(json['doctorId'] as String),
        userId: ObjectId.parse(json['userId'] as String),
        date:DateTime(json['date']),
        startTime:json['startTime'],
        endTime:json['endTime'],
        status: getStatus(json['status'])
      );
    }

    //Convert to JSON
    Map<String, dynamic> toJson() {
      return {
        'doctorId': doctorId.oid,
        'userId': userId.oid,
        'date': date.toIso8601String(),
        'startTime': startTime,
        'endTime': endTime,
        'status': status.toShortString(),
      };
    }

}