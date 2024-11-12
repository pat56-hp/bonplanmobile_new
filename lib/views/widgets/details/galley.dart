import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/models/gallery.dart';
import 'package:mobile/utils/apiEndPoint.dart';
import 'package:mobile/views/widgets/ImageWidget.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({super.key, required this.gallery});

  final List<Gallery> gallery;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.gallery
        .map((image) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ImageWidget(
              imgUrl: ApiEndPoint.apiUrlDomaine + image.image.toString(),
              borderRadius: 15.0,
            )))
        .toList();

    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            enlargeCenterPage: true,
            height: 180,
            autoPlayInterval: const Duration(seconds: 10),
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.gallery.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? appBarBackground
                      : galeryIndicator,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
