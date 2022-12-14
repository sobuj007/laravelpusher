// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
      required  this.id,
      required  this.name,
      required  this.email,
      required  this.phone,
      required  this.gender,
      required  this.thumbnail,
      required  this.dob,
      required  this.type,
      required  this.status,
    });

    int id;
    String name;
    String email;
    String phone;
    String gender;
    String thumbnail;
    DateTime dob;
    String type;
    String status;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        thumbnail: json["thumbnail"],
        dob: DateTime.parse(json["dob"]),
        type: json["type"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "thumbnail": thumbnail,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "type": type,
        "status": status,
    };
}
