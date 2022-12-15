// To parse this JSON data, do
//
//     final chatRoomMessage = chatRoomMessageFromJson(jsonString);

import 'dart:convert';

List<ChatRoomMessage> chatRoomMessageFromJson(String str) => List<ChatRoomMessage>.from(json.decode(str).map((x) => ChatRoomMessage.fromJson(x)));

String chatRoomMessageToJson(List<ChatRoomMessage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatRoomMessage {
    ChatRoomMessage({
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
    User1? user;

    factory ChatRoomMessage.fromJson(Map<String, dynamic> json) => ChatRoomMessage(
        id: json["id"],
        chatId: json["chat_id"],
        userId: json["user_id"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User1.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chatId,
        "user_id": userId,
        "message": message,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
    };
}

class User1 {
    User1({
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

    factory User1.fromJson(Map<String, dynamic> json) => User1(
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
