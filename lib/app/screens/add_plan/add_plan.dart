import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddPlan extends ConsumerWidget {
  AddPlan({super.key});

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          // White arrow button at the top-left corner
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (context.mounted) {
                  context.go('/home'); // Redirect to home page
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
                        'Search For Your First Flight',
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
                // Button for searching by airports
                ElevatedButton.icon(
                  onPressed: () async {
                    if (context.mounted) {
                      context.go('/searchByAirport');
                    }
                  },
                  label: const Text('Search Flight By Airports'),
                  icon: const Icon(Icons.arrow_forward),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Default background color
                    foregroundColor: Colors.blue, // Text and icon color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(25), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0), // Button padding
                  ),
                ),
                const SizedBox(height: 20),
                // Button for searching by flight number
                ElevatedButton.icon(
                  onPressed: () async {
                    if (context.mounted) {
                      context.go('/searchByFlightNum');
                    }
                  },
                  label: const Text('Search Flight By Flight Number'),
                  icon: const Icon(Icons.arrow_forward),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Default background color
                    foregroundColor: Colors.blue, // Text and icon color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(25), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0), // Button padding
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
