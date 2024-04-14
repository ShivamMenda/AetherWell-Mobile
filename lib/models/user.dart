//Import mongo for Object id
import 'package:mongo_dart/mongo_dart.dart';

//User model
//Defining an enum for role
enum UserRole { user, doctor }

//Pasring the enum to an string
extension ParseToString on UserRole {
  String toShortString() {
    return toString().split('.').last;
  }
}

class User {
  //Required fields
  late String name;
  late String email;
  //Note Password is for sending and while receiving we dont need it so it will be an empty String in the factory convertor.
  //late String password;
  late String username;
  //We can consider using enum and a conveter to string
  late UserRole role;

  //Nullable fields
  int? age;
  String? gender;
  String? address;
  String? phone;
  //User id synthesised in backend and sent
  ObjectId? id;

  //Constructor
  User({
    required this.name,
    required this.email,
    //required this.password,
    required this.username,
    required this.role,
    this.age,
    this.gender,
    this.address,
    this.phone,
    this.id,
  });
  //Setting up mapper
  factory User.fromJSON(Map<String, dynamic> json, String id) {
    UserRole role = json['role'] == 'doctor' ? UserRole.doctor : UserRole.user;
    return User(
      name: json['name'],
      email: json['email'],
      //Password will not be reutrned just for modelling and sending JSON we have the field.
      //password: "",
      username: json['username'],
      role: role,
      age: json['age'] as int,
      gender: json['gender'],
      address: json['address'],
      phone: json['phone'],
      id: ObjectId.parse(id),
    );
  }

  //Mapper to map to json
  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'email': email,
      //'password': password,
      //'username': username,
      'role': role.name,
      'age': age,
      'gender': gender,
      'address': address,
      'phone': phone,
    };
  }
}
