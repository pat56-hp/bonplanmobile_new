import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  int type;
  String name;
  String lastname;
  String email;
  String phone;
  String? image;
  String? adresse;
  int status;
  int validate;
  DateTime createdAt;

  User({
    required this.id,
    required this.type,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    this.image,
    this.adresse,
    required this.status,
    required this.validate,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"] ?? '',
        adresse: json["adresse"] ?? '',
        status: json["status"],
        validate: json["validate"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "image": image ?? '',
        "adresse": adresse ?? '',
        "status": status,
        "validate": validate,
        "created_at": createdAt.toIso8601String(),
      };
}
