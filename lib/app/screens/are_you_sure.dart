import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AreYouSure extends ConsumerWidget {
  AreYouSure({super.key});

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
            ),
            //button to go back home
            child: ElevatedButton.icon(
              onPressed: () async {
                if (context.mounted) {
                  context.go('/home');
                }
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Set the background color to white
              ),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double maxWidth = constraints.maxWidth * 0.7;
              return SizedBox(
                width: maxWidth,
                child: const Text(
                  'Are You Sure You Want To Create A New Flight Plan?',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Optional: Center the text
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
            ),
            //button to go back home
            child: ElevatedButton.icon(
              onPressed: () async {
                if (context.mounted) {
                  context.go('/searchFirstHome');
                }
              },
              label: const Text('YES'),
              icon: const Icon(Icons.check_circle),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Set the background color to white
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 0.0,
            ),
            //button to go back home
            child: ElevatedButton.icon(
              onPressed: () async {
                if (context.mounted) {
                  context.go('/home');
                }
              },
              label: const Text('NO'),
              icon: const Icon(Icons.cancel),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Set the background color to white
              ),
            ),
          ),
          const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 400.0),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(0.0)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
