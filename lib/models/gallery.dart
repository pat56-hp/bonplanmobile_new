import 'dart:convert';

Gallery galleryFromJson(String str) => Gallery.fromJson(json.decode(str));

String galleryToJson(Gallery data) => json.encode(data.toJson());

class Gallery {
  int? id;
  int? etablissementId;
  dynamic eventId;
  String? image;

  Gallery({
    this.id,
    this.etablissementId,
    this.eventId,
    this.image,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        etablissementId: json["etablissement_id"],
        eventId: json["event_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "etablissement_id": etablissementId,
        "event_id": eventId,
        "image": image,
      };
}
