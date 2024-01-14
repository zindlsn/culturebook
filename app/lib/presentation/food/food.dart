import 'package:app/presentation/explore/explore.dart';
import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key, required String food});

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sauerbraten')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
                child: Placeholder(
                    child: Center(child: Text('Beliebte Restaurants')))),
            Expanded(
              child: Center(
                  child: Column(
                children: [
                  const Text('Lokale Rezepte'),
                  Expanded(
                      child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Image.network(imgList.first),
                              const Row(
                                children: [
                                  Icon(Icons.directions),
                                  Text('Auf dem Mark 5'),
                                ],
                              ),
                              const Text('70478 Stuttgart'),
                              const Text('Tel. 07845 878458')
                            ],
                          )))
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
