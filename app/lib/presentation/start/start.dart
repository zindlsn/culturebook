import 'package:app/presentation/explore/explore.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Entdecke deine nächste Stadt'),
            SearchBar(trailing: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ExplorePage()));
                  },
                  child: const Icon(Icons.search))
            ]),
          ],
        ),
      ),
    );
  }
}

