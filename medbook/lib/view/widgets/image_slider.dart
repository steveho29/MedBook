import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<String> listImages;

  const ImageSlider({required this.listImages});
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: widget.listImages
            .map((e) => ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        e,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: 1.0,
          enlargeCenterPage: true,
        ));
  }
}
