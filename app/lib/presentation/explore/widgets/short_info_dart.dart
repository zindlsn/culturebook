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
                  viewportFraction: deviceSize.width > 800.0 ? 0.2 : 1.0,
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
    height: 800.0 + 3 * 50,
    color: Colors.primaries[index % Colors.primaries.length],
  ),
);

var generalInfo = Slide(color: Colors.black, height: 600.0, title:
'''
Stuttgart (schwäbisch Schduágórd = Stutengarten)
Landeshauptstadt Baden-Württemberg
Einwohnerzahl: 632.865
''');

final List<Widget> sliders = slides
    .map(
      (item) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          child: Container(
            color: item.color,
            width: double.infinity,
            height: item.height,
            child: Center(
              child: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    )
    .toList();
