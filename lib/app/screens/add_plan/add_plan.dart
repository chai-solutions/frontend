import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddPlan extends ConsumerWidget {
  AddPlan({super.key});

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
          Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
            ),
            //button to go back home
            child: ElevatedButton.icon(
              onPressed: () async {
                if (context.mounted) {
                  context.go('/searchByAirport');
                }
              },
              label: const Text('Search Flight By Airports'),
              icon: const Icon(Icons.arrow_forward),
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
                  context.go('/searchByFlightNum');
                }
              },
              label: const Text('Search Flight By Flight Number'),
              icon: const Icon(Icons.arrow_forward),
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
            ),
          ),
        ],
      ),
    );
  }
}
