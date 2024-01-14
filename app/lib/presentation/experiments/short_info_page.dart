import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

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

var generalInfo = Slide(
    color: Colors.black,
    height: 600.0,
    title: '''Stuttgart (schwäbisch Schduágórd = Stutengarten)
Landeshauptstadt Baden-Württemberg
Einwohnerzahl: 632.865''');

var slides = List.generate(
  3,
  (index) => Slide(
    title: 'Slide ${index + 1}',
    height: 100.0 + index * 50,
    color: Colors.primaries[index % Colors.primaries.length],
  ),
);

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

class FlutterCarouselWidgetDemo extends StatelessWidget {
  const FlutterCarouselWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (ctx) => const CarouselDemoHome(),
        '/complicated': (ctx) => const ComplicatedImageDemo(),
        '/enlarge': (ctx) => const EnlargeStrategyDemo(),
        '/manual': (ctx) => const ManuallyControlledSlider(),
        '/fullscreen': (ctx) => const FullscreenSliderDemo(),
        '/indicator': (ctx) => const CarouselWithIndicatorDemo(),
        '/multiple': (ctx) => const MultipleItemDemo(),
        '/expandable': (ctx) => const ExpandableCarouselDemo(),
        '/page_changed_reason': (ctx) => const PageChangedReason(),
      },
      themeMode: ThemeMode.system,
    );
  }
}

class DemoItem extends StatelessWidget {
  const DemoItem(this.title, this.route, {super.key});

  final String route;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        color: Colors.blueAccent,
        margin: const EdgeInsets.only(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

class CarouselDemoHome extends StatelessWidget {
  const CarouselDemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carousel Demo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: ListView(
            shrinkWrap: true,
            children: const [
              SizedBox(height: 8.0),
              DemoItem('Image Slider Demo', '/complicated'),
              DemoItem('Enlarge Strategy Demo', '/enlarge'),
              DemoItem('Manually Controlled Slider', '/manual'),
              DemoItem('Fullscreen Carousel Slider', '/fullscreen'),
              DemoItem('Carousel with Custom Indicator Demo', '/indicator'),
              DemoItem('Multiple Item in One Screen Demo', '/multiple'),
              DemoItem('Expandable Carousel Demo', '/expandable'),
              DemoItem('Page Changed Reason Demo', "/page_changed_reason"),
            ],
          ),
        ),
      ),
    );
  }
}

class ComplicatedImageDemo extends StatelessWidget {
  const ComplicatedImageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    slides.add(generalInfo);
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width,
        ),
        child: FlutterCarousel(
          options: CarouselOptions(
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            disableCenter: true,
            viewportFraction: deviceSize.width > 800.0 ? 0.3 : 1.0,
            height: deviceSize.height * 0.45,
            indicatorMargin: 12.0,
            enableInfiniteScroll: true,
            slideIndicator: const CircularSlideIndicator(),
          ),
          items: sliders,
        ),
      ),
    );
  }
}

class EnlargeStrategyDemo extends StatelessWidget {
  const EnlargeStrategyDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Center Enlarge Strategy Demo')),
      body: Center(
        child: FlutterCarousel(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            slideIndicator: CircularWaveSlideIndicator(),
            floatingIndicator: false,
          ),
          items: sliders,
        ),
      ),
    );
  }
}

class PageChangedReason extends StatefulWidget {
  const PageChangedReason({super.key});

  @override
  State<PageChangedReason> createState() => _PageChangedReasonState();
}

class _PageChangedReasonState extends State<PageChangedReason> {
  CarouselController? controller = CarouselController();
  bool autoplay = false;
  CarouselPageChangedReason? lastReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text('Page Changed Reason'),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              autoplay = !autoplay;
              print('autoplay toggled');
            }),
            icon: Icon(autoplay ? Icons.pause : Icons.play_arrow),
          ),
          IconButton(
            onPressed: () => setState(() {
              controller = controller == null ? CarouselController() : null;
              print('controller toggled');
            }),
            icon: Icon(
              controller == null ? Icons.gamepad_outlined : Icons.gamepad,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Last changed reason:\n${lastReason != null ? lastReason!.toString() : 'None'}'),
            Expanded(
              child: FlutterCarousel(
                items: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Placeholder(
                      fallbackHeight: 200.0,
                      fallbackWidth: 200.0,
                    ),
                  )
                ],
                options: CarouselOptions(
                  onPageChanged: (_, reason) => setState(
                    () {
                      lastReason = reason;
                      print(reason);
                    },
                  ),
                  controller: controller,
                  enableInfiniteScroll: true,
                  autoPlay: autoplay,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ManuallyControlledSlider extends StatefulWidget {
  const ManuallyControlledSlider({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ManuallyControlledSliderState();
  }
}

class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manually Controlled Slider')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: FlutterCarousel(
                  items: sliders,
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    autoPlay: false,
                    floatingIndicator: false,
                    enableInfiniteScroll: true,
                    controller: _controller,
                    slideIndicator: CircularWaveSlideIndicator(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        onPressed: _controller.previousPage,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: _controller.nextPage,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FullscreenSliderDemo extends StatelessWidget {
  const FullscreenSliderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fullscreen Slider Demo')),
      body: Center(
        child: Builder(
          builder: (context) {
            final height = MediaQuery.of(context).size.height;
            return FlutterCarousel(
              options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 2),
                slideIndicator: CircularWaveSlideIndicator(),
              ),
              items: sliders,
            );
          },
        ),
      ),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Indicator Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterCarousel(
              items: sliders,
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  viewportFraction: 1.0,
                  showIndicator: false,
                  height: 400.0,
                  onPageChanged: (int index, CarouselPageChangedReason reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: slides.asMap().entries.map((entry) {
                return Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MultipleItemDemo extends StatelessWidget {
  const MultipleItemDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiple Item in One Slide Demo')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800.0),
          child: FlutterCarousel.builder(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              viewportFraction: 1,
              showIndicator: true,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlay: true,
              slideIndicator: CircularStaticIndicator(),
            ),
            itemCount: (slides.length / 2).round(),
            itemBuilder: (context, index, realIdx) {
              final first = index * 2;
              final second = first + 1;
              return Row(
                children: [first, second].map((idx) {
                  return Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        color: slides[idx].color,
                        height: slides[idx].height,
                        child: Center(
                          child: Text(slides[idx].title),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ExpandableCarouselDemo extends StatefulWidget {
  const ExpandableCarouselDemo({super.key});

  @override
  State<ExpandableCarouselDemo> createState() => _ExpandableCarouselDemoState();
}

class _ExpandableCarouselDemoState extends State<ExpandableCarouselDemo> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expandable Carousel Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ExpandableCarousel(
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
                controller: _controller,
                floatingIndicator: false,
                restorationId: 'expandable_carousel',
              ),
              items: sliders,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: _controller.previousPage,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: _controller.nextPage,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
