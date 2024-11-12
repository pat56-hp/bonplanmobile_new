import 'package:mobile/models/commentaire.dart';
import 'package:mobile/models/commodite.dart';
import 'package:mobile/models/gallery.dart';
import 'package:mobile/models/horaire.dart';

class Etablissement {
  int? id;
  String? category;
  int? categoryId;
  String? categoryIcon;
  List<Commodite>? commodites;
  String? libelle;
  String? ville;
  String? adresse;
  double? longitude;
  double? latitude;
  String? phone;
  String? email;
  String? facebook;
  String? instagram;
  String? image;
  List<Gallery>? gallery;
  int? status;
  int? validate;
  String? description;
  int? totalImage;
  bool? open;
  bool? favoris;
  int? note;
  List<Commentaire>? commentaires;
  List<Horaire>? horaire;
  String? createdAt;

  Etablissement({
    this.id,
    this.category,
    this.categoryId,
    this.categoryIcon,
    this.commodites,
    this.libelle,
    this.ville,
    this.adresse,
    this.longitude,
    this.latitude,
    this.phone,
    this.email,
    this.facebook,
    this.instagram,
    this.image,
    this.gallery,
    this.status,
    this.validate,
    this.description,
    this.totalImage,
    this.open,
    this.favoris,
    this.note,
    this.commentaires,
    this.horaire,
    this.createdAt,
  });

  // Méthode pour vérifier si l'établissement est ouvert ou fermé
  String get statusOuverture {
    return open == true ? "Ouvert" : "Fermé";
  }

  factory Etablissement.fromJson(Map<String, dynamic> json) => Etablissement(
        id: json["id"],
        category: json["category"] ?? '', // Valeur par défaut si null
        categoryId: json["category_id"] ?? 0,
        categoryIcon: json["category_icon"] ?? '',
        commodites: json["commodites"] == null
            ? []
            : List<Commodite>.from(
                json["commodites"].map((x) => Commodite.fromJson(x))),
        libelle: json["libelle"] ?? '',
        ville: json["ville"] ?? '',
        adresse: json["adresse"] ?? '',
        longitude: json["longitude"]?.toDouble() ?? 0.0,
        latitude: json["latitude"]?.toDouble() ?? 0.0,
        phone: json["phone"] ?? '',
        email: json["email"] ?? '',
        facebook: json["facebook"] ?? '',
        instagram: json["instagram"] ?? '',
        image: json["image"] ?? '',
        gallery: json["gallery"] == null
            ? []
            : List<Gallery>.from(
                json["gallery"].map((x) => Gallery.fromJson(x))),
        status: json["status"] ?? 0,
        validate: json["validate"] ?? 0,
        description: json["description"] ?? '',
        totalImage: json["total_image"] ?? 0,
        open: json["open"] ?? false,
        favoris: json["favoris"] ?? false,
        note: json["note"] ?? 0,
        commentaires: json["commentaires"] == null
            ? []
            : List<Commentaire>.from(
                json["commentaires"].map((x) => Commentaire.fromJson(x))),
        horaire: json["horaire"] == null
            ? []
            : List<Horaire>.from(
                json["horaire"].map((x) => Horaire.fromJson(x))),
        createdAt: json["created_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0, // Utilisez une valeur par défaut si `null`
        "category": category ?? '',
        "category_id": categoryId ?? 0,
        "category_icon": categoryIcon ?? '',
        "commodites": commodites != null
            ? List<dynamic>.from(commodites!.map((x) => x.toJson()))
            : [],
        "libelle": libelle ?? '',
        "ville": ville ?? '',
        "adresse": adresse ?? '',
        "longitude": longitude ?? 0.0,
        "latitude": latitude ?? 0.0,
        "phone": phone ?? '',
        "email": email ?? '',
        "facebook": facebook ?? '',
        "instagram": instagram ?? '',
        "image": image ?? '',
        "gallery": gallery != null
            ? List<dynamic>.from(gallery!.map((x) => x.toJson()))
            : [],
        "status": status ?? 0,
        "validate": validate ?? 0,
        "description": description ?? '',
        "total_image": totalImage ?? 0,
        "open": open ?? false,
        "favoris": favoris ?? false,
        "note": note ?? 0,
        "commentaires": commentaires != null
            ? List<dynamic>.from(commentaires!.map((x) => x.toJson()))
            : [],
        "horaire": horaire != null
            ? List<dynamic>.from(horaire!.map((x) => x.toJson()))
            : [],
        "created_at": createdAt ?? '',
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
