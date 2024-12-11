import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AreYouSure extends ConsumerWidget {
  AreYouSure({super.key});

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          // Left arrow button at the top-left corner
          Positioned(
            top: 70,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (context.mounted) {
                  context.go('/home');
                }
              },
            ),
          ),
          // Main content of the screen
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        textAlign: TextAlign.center, // Center the text
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (context.mounted) {
                      context.go('/searchFirstHome');
                    }
                  },
                  label: const Text('YES'),
                  icon: const Icon(Icons.check_circle),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (context.mounted) {
                      context.go('/home');
                    }
                  },
                  label: const Text('NO'),
                  icon: const Icon(Icons.cancel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
