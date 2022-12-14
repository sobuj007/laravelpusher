// To parse this JSON data, do
//
//     final chats = chatsFromJson(jsonString);

import 'dart:convert';

Chats chatsFromJson(String str) => Chats.fromJson(json.decode(str));

String chatsToJson(Chats data) => json.encode(data.toJson());

class Chats {
    Chats({
      this.id,
       this.createdBy,
      this.name,
       this.isPrivate,
      this.createdAt,
  this.updatedAt,
  this. lastMessage,
      this.participants,
    });

    int? id;
    int? createdBy;
    String? name;
    int? isPrivate;
    DateTime? createdAt;
    DateTime? updatedAt;
    LastMessage? lastMessage;
    List<Participant>? participants;

    factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        id: json["id"],
        createdBy: json["created_by"],
        name: json["name"],
        isPrivate: json["is_private"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
         lastMessage: LastMessage.fromJson(json["last_message"]),
        participants: List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "name": name,
        "is_private": isPrivate,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "last_message": lastMessage!.toJson(),
        "participants": List<dynamic>.from(participants!.map((x) => x.toJson())),
    };
}

class LastMessage {
    LastMessage({
        this.id,
        this.chatId,
        this.userId,
        this.message,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    int? id;
    int? chatId;
    int? userId;
    String? message;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["id"],
        chatId: json["chat_id"],
        userId: json["user_id"],
        message: json["message"] == null ? null : json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chatId,
        "user_id": userId,
        "message": message == null ? null : message,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
    };
}

class Participant {
    Participant({
        this.id,
        this.chatId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    int? id;
    int? chatId;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        chatId: json["chat_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chatId,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
    };
}
class User {
    User({
      this.id,
      this.name,
      this.email,
      this.phone,
      this.gender,
      this.thumbnail,
      this.dob,
      this.type,
    });

    int? id;
    String? name;
    String? email;
    String? phone;
    String? gender;
    String? thumbnail;
    DateTime? dob;
    String? type;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        thumbnail: json["thumbnail"],
        dob: DateTime.parse(json["dob"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "thumbnail": thumbnail,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "type": type,
    };
}
