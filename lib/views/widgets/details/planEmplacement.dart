import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/models/etablissement.dart';
import 'package:mobile/views/widgets/CatLoc.dart';
import 'package:mobile/views/widgets/IconButtonWidget.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanEmplacement extends StatelessWidget {
  const PlanEmplacement({super.key, required this.etablissement});

  final Etablissement etablissement;

  //Ouverture de lien Url
  Future<void> openUrl(String url) async {
    final Uri urlParse = Uri.parse(url);
    if (await canLaunchUrl(urlParse)) {
      await launchUrl(urlParse);
    } else {
      print('Impossible d\'ouvrir le lien');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
            label: 'Emplacement & Réseaux sociaux',
            extra: {'color': titleColor, 'fontWeight': FontWeight.w500}),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 155,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              border: Border.all(color: favorisBackground, width: 0.8),
              borderRadius: BorderRadius.circular(25)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: FlutterMap(
              options: MapOptions(
                initialCenter:
                    LatLng(etablissement.latitude!, etablissement.longitude!),
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                MarkerLayer(markers: [
                  Marker(
                    point: LatLng(
                        etablissement.latitude!, etablissement.longitude!),
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.asset(
                        'assets/images/marker.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: CatLoc(
                  icon: 'assets/icons/marker.svg',
                  label: '${etablissement.ville}',
                  maxLines: 2,
                ),
              ),
            ),
            Row(
              children: [
                if (etablissement.facebook != null &&
                    etablissement.facebook != '')
                  IconButtonWidget(
                    backgroundColor: favorisBackground,
                    icon: 'assets/icons/facebook.svg',
                    padding: 0,
                    sizeIcon: 18,
                    borderRadius: 50,
                    pressFunction: () =>
                        openUrl(etablissement.facebook.toString()),
                  ),
                if (etablissement.instagram != null &&
                    etablissement.instagram != '')
                  IconButtonWidget(
                    backgroundColor: favorisBackground,
                    icon: 'assets/icons/instagram.svg',
                    padding: 0,
                    sizeIcon: 18,
                    borderRadius: 50,
                    pressFunction: () =>
                        openUrl(etablissement.instagram.toString()),
                  )
              ],
            )
          ],
        )
      ],
    );
  }
}
