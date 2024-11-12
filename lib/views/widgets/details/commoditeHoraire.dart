import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/models/commodite.dart';
import 'package:mobile/models/horaire.dart';
import 'package:mobile/views/widgets/CatLoc.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:intl/intl.dart';

class CommoditeHoraire extends StatefulWidget {
  const CommoditeHoraire(
      {super.key, required this.commodite, required this.horaire});

  final List<Commodite>? commodite;
  final List<Horaire>? horaire;

  @override
  State<CommoditeHoraire> createState() => _CommoditeHoraireState();
}

class _CommoditeHoraireState extends State<CommoditeHoraire> {
  List days = [
    {"id": "1", "day": "Lundi"},
    {"id": "2", "day": "Mardi"},
    {"id": "3", "day": "Mercredi"},
    {"id": "4", "day": "Jeudi"},
    {"id": "5", "day": "Vendredi"},
    {"id": "6", "day": "Samedi"},
    {"id": "7", "day": "Dimanche"},
  ];

  String formatTime(String time) {
    DateTime dateTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("HH:mm").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.horaire!.map((e) => e.libelle));

    String getHours(dayId) {
      var hour =
          widget.horaire!.where((h) => h.id.toString() == dayId).firstOrNull;

      return hour?.pivot?.ouverture != null
          ? '${formatTime(hour!.pivot!.ouverture.toString())} - ${formatTime(hour.pivot!.fermeture.toString())}'
          : 'Fermé';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
              label: 'Commodités',
              extra: {'color': titleColor, 'fontWeight': FontWeight.w500}),
          const SizedBox(
            height: 15,
          ),
          Wrap(
              spacing: 10, // Espace horizontal entre les éléments
              runSpacing: 10, // Espace vertical entre les lignes
              children: widget.commodite!
                  .map((item) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CatLoc(
                            icon: 'assets/icons/bookmark.svg',
                            label: item.libelle.toString(),
                          ),
                        ],
                      ))
                  .toList()),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              height: 0.8,
              width: 200,
              color: borderActive,
            ),
          ),
          const TextWidget(
              label: 'Horaires',
              extra: {'color': titleColor, 'fontWeight': FontWeight.w500}),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: days
                      .sublist(0, 4) // Les quatre premiers jours
                      .map((day) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                label: day['day'],
                              ),
                              TextWidget(
                                label: getHours(day['id']),
                                extra: const {'color': textRed, 'size': 15.0},
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: days
                      .sublist(4) // Les quatre premiers jours
                      .map((day) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                label: day['day'],
                              ),
                              TextWidget(
                                label: getHours(day['id']),
                                extra: const {'color': textRed, 'size': 15.0},
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
