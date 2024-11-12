// To parse this JSON data, do
//
//     final commodite = commoditeFromJson(jsonString);

import 'dart:convert';

Commodite commoditeFromJson(String str) => Commodite.fromJson(json.decode(str));

String commoditeToJson(Commodite data) => json.encode(data.toJson());

class Commodite {
  int? id;
  String? libelle;
  String? icon;
  int? status;
  Pivot? pivot;

  Commodite({
    required this.id,
    required this.libelle,
    this.icon,
    required this.status,
    this.pivot,
  });

  factory Commodite.fromJson(Map<String, dynamic> json) => Commodite(
        id: json["id"] ?? 0,
        libelle: json["libelle"] ?? '',
        icon: json["icon"] ?? '',
        status: json["status"] ?? 0,
        pivot: json["pivot"] != null ? Pivot.fromJson(json["pivot"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "icon": icon,
        "status": status,
        "pivot": pivot!.toJson(),
      };
}

class Pivot {
  int? etablissementId;
  int? commoditeId;

  Pivot({
    this.etablissementId,
    this.commoditeId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        etablissementId: json["etablissement_id"] ?? 0,
        commoditeId: json["commodite_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "etablissement_id": etablissementId,
        "commodite_id": commoditeId,
      };
}

class CommoditePivot {
  int? etablissementId;
  int? commoditeId;

  CommoditePivot({
    this.etablissementId,
    this.commoditeId,
  });

  factory CommoditePivot.fromJson(Map<String, dynamic> json) => CommoditePivot(
        etablissementId: json["etablissement_id"] ?? 0,
        commoditeId: json["commodite_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "etablissement_id": etablissementId,
        "commodite_id": commoditeId,
      };
}
