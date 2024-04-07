//import mongo db package for object id
import 'package:mongo_dart/mongo_dart.dart';

//slot schema
class SlotSchema {
  late String start;
  late String end;
  late String status;

  SlotSchema({
    required this.start,
    required this.end,
    required this.status
  });

  factory SlotSchema.fromJson(Map<String, dynamic> json) {
    //by default as string
    return SlotSchema(
      start: json['start'] as String,
      end: json['end'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
      'status': status,
    };
  }
}

//day avaialbility schema
class DayAvailabilitySchema {
  late String day;
  late List<SlotSchema> slots;

  DayAvailabilitySchema({required this.day, required this.slots});

  factory DayAvailabilitySchema.fromJson(Map<String, dynamic> json) {
    return DayAvailabilitySchema(
      day: json['day'] as String,
      slots: (json['slots'] as List).map((slotJson) => SlotSchema.fromJson(slotJson)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'slots': slots.map((slot) => slot.toJson()).toList(),
    };
  }
}
//enum for doctor role

//Defining an enum for role
enum DoctorRole{
  user,
  doctor
}
//Pasring the enum to an string
extension ParseToString on DoctorRole{
  String toShortString() {
    return toString().split('.').last;
  }
}
//doctor main schema
class Doctor {
  late String username;
  late String password;
  late String email;
  late DoctorRole role;
  late String name;
  late int age;
  late String specialization;
  late String hospital;
  String? address;
  String? phone;
  ObjectId? id;
  late List<DayAvailabilitySchema> availability;

  Doctor({
    required this.username,
    required this.password,
    required this.email,
    required this.role,
    required this.name,
    required this.age,
    required this.specialization,
    required this.hospital,
    this.address,
    this.phone,
    this.id,
    required this.availability,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      username: json['username'] as String,
      password:"",
      email: json['email'] as String,
      role: json['role']=="doctor"?DoctorRole.doctor:DoctorRole.user,
      name: json['name'] as String,
      age:json['age'] as int,
      specialization: json['specialization'] as String,
      hospital: json['hospital'] as String,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      id: json['id'] != null ? ObjectId.parse(json['id'] as String) : null,
      availability: (json['availability'] as List).map((dayJson) => DayAvailabilitySchema.fromJson(dayJson)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'role': role.name,
      'age':age,
      'name': name,
      'specialization': specialization,
      'hospital': hospital,
      'address': address,
      'phone': phone,
      'availability': availability.map((dayAvailability) => dayAvailability.toJson()).toList(),
    };
  }
}
