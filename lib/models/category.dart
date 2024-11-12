// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int? id;
  String? libelle;
  String? icon;
  int? totalEntreprise;

  Category({
    required this.id,
    required this.libelle,
    required this.icon,
    required this.totalEntreprise,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        libelle: json["libelle"],
        icon: json["icon"],
        totalEntreprise: json["total_entreprise"],
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "libelle": libelle!,
        "icon": icon!,
        "total_entreprise": totalEntreprise!,
      };
}
