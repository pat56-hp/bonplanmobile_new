// To parse this JSON data, do
//
//     final commentaire = commentaireFromJson(jsonString);

import 'dart:convert';

Commentaire commentaireFromJson(String str) =>
    Commentaire.fromJson(json.decode(str));

String commentaireToJson(Commentaire data) => json.encode(data.toJson());

class Commentaire {
  int? id;
  String? commentaire;
  int? note;
  int? clientId;
  int? etablissementId;
  DateTime? createdAt;
  String? date;
  Client? client;

  Commentaire({
    this.id,
    this.commentaire,
    this.note,
    this.clientId,
    this.etablissementId,
    this.createdAt,
    this.date,
    this.client,
  });

  factory Commentaire.fromJson(Map<String, dynamic> json) => Commentaire(
        id: json["id"],
        commentaire: json["commentaire"],
        note: json["note"],
        clientId: json["client_id"],
        etablissementId: json["etablissement_id"],
        createdAt: DateTime.parse(json["created_at"]),
        date: json["date"],
        client: Client.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "commentaire": commentaire,
        "note": note,
        "client_id": clientId,
        "etablissement_id": etablissementId,
        "created_at": createdAt!.toIso8601String(),
        "date": date,
        "client": client!.toJson(),
      };
}

class Client {
  int id;
  int type;
  String name;
  String lastname;
  String email;
  String phone;
  String image;
  dynamic adresse;
  int status;
  int validate;
  DateTime createdAt;

  Client({
    required this.id,
    required this.type,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.image,
    required this.adresse,
    required this.status,
    required this.validate,
    required this.createdAt,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        adresse: json["adresse"],
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
    "image": image,
    "adresse": adresse,
    "status": status,
    "validate": validate,
    "created_at": createdAt.toIso8601String(),
  };
}
