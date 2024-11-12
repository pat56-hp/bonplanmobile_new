import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.imgUrl, this.borderRadius});

  final String imgUrl;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            const LoadingCircularProgress(color: appBarBackground),
        errorWidget: (context, url, error) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 40),
                const SizedBox(height: 10),
                const Text('Erreur de chargement',
                    style: TextStyle(color: Colors.red)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Essayer de recharger l'image en cliquant sur le bouton
                    print('Tentative de rechargement...');
                  },
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
