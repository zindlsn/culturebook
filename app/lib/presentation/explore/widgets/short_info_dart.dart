import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class ShortInfoCard extends StatefulWidget {
  const ShortInfoCard({super.key});

  @override
  State<ShortInfoCard> createState() => _ShortInfoCardState();
}

class _ShortInfoCardState extends State<ShortInfoCard> {
  @override
  void initState() {
    slides.add(generalInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.width,
          ),
          child: Column(
            children: [
              const Wrap(
                children: [
                  Chip(
                    label: Text('General'),
                  ),
                  Chip(
                    label: Text('People'),
                  ),
                ],
              ),
              FlutterCarousel(
                options: CarouselOptions(
                  autoPlay: false,
                  disableCenter: true,
                  viewportFraction: deviceSize.width > 800.0 ? 0.4 : 1.0,
                  height: deviceSize.height * 0.45,
                  indicatorMargin: 12.0,
                  enableInfiniteScroll: true,
                  slideIndicator: const CircularSlideIndicator(),
                ),
                items: sliders,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Slide {
  Slide({
    required this.title,
    required this.height,
    required this.color,
  });

  final Color color;
  final double height;
  final String title;
}

var slides = List.generate(
  1,
  (index) => Slide(
    title: 'Slide ${index + 1}',
    height: 100.0 + index * 50,
    color: Colors.primaries[index % Colors.primaries.length],
  ),
);

var generalInfo = Slide(
    color: Colors.black,
    height: 100.0,
    title:
        'Stuttgart (schwäbisch Schduágórd; um das Jahr 950 Stuotgarten; ursprüngliche Bedeutung Stutengarten) ist die Landeshauptstadt des Landes Baden-Württemberg und mit 632.865 Einwohnern (31. Dezember 2022) dessen bevölkerungsreichste Stadt.');

final List<Widget> sliders = slides
    .map(
      (item) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
            ),
            width: double.infinity,
            height: item.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    )
    .toList();
