class Horaire {
  int? id;
  String? libelle;
  DateTime? createdAt;
  DateTime? updatedAt;
  HorairePivot? pivot;

  Horaire({
    this.id,
    this.libelle,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Horaire.fromJson(Map<String, dynamic> json) => Horaire(
        id: json["id"] ?? 0,
        libelle: json["libelle"] ?? '',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pivot:
            json["pivot"] == null ? null : HorairePivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "pivot": pivot!.toJson(),
      };
}

class HorairePivot {
  int? etablissementId;
  int? jourId;
  String? ouverture;
  String? fermeture;

  HorairePivot({
    this.etablissementId,
    this.jourId,
    this.ouverture,
    this.fermeture,
  });

  factory HorairePivot.fromJson(Map<String, dynamic> json) => HorairePivot(
        etablissementId: json["etablissement_id"],
        jourId: json["jour_id"],
        ouverture: json["ouverture"],
        fermeture: json["fermeture"],
      );

  Map<String, dynamic> toJson() => {
        "etablissement_id": etablissementId,
        "jour_id": jourId,
        "ouverture": ouverture,
        "fermeture": fermeture,
      };
}
