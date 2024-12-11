import 'package:flutter/material.dart';
import 'package:chai/providers/http_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

class AreYouSureDelPlan extends ConsumerStatefulWidget {
  final int? inputPlanId;

  const AreYouSureDelPlan({super.key, required this.inputPlanId});

  @override
  AreYouSureDelPlanState createState() => AreYouSureDelPlanState();
}

class AreYouSureDelPlanState extends ConsumerState<AreYouSureDelPlan> {
  final myController = TextEditingController();
  final planNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>?> deleteFlightPlan(int? flightNum) async {
      try {
        //authorize query
        final client = ref.read(httpClientProvider);
        //submit query
        final response =
            await client.delete('/flight_plans/${widget.inputPlanId}');
        final statusCode = response.statusCode;
        //flight found
        if (statusCode == 204) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          setState(() {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Success!'),
                content: Text('Deleted flight plan.'),
              ),
            );
            if (context.mounted) {
              context.go('/Home');
            }
          });
          return data;
        } else {
          //flight not found
          setState(() {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Error'),
                content: Text(
                    'Could not add flight to flight plan. \nInvalid flight code.'),
              ),
            );
          });
        }
      } catch (error) {
        // invalid flight code
      }
      return null;
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 100.0,
            ),
            //button to go back home
            child: ElevatedButton.icon(
              onPressed: () async {
                if (context.mounted) {
                  context.go('/addDeleteFlight/${widget.inputPlanId}');
                }
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Set the background color to white
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 300.0),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        double maxWidth = constraints.maxWidth * 0.7;
                        return SizedBox(
                          width: maxWidth,
                          child: const Text(
                            'Are you sure you want to permanently delete this flight plan?',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign:
                                TextAlign.center, // Optional: Center the text
                          ),
                        );
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 75.0,
                      ),
                      //button to delete current flight plan, then go home
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await deleteFlightPlan(widget.inputPlanId);
                          if (context.mounted) {
                            context.go('/home');
                          }
                        },
                        label: const Text('YES'),
                        icon: const Icon(Icons.check_circle),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0.0,
                      ),
                      //button to go back to flight plan
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (context.mounted) {
                            context
                                .go('/addDeleteFlight/${widget.inputPlanId}');
                          }
                        },
                        label: const Text('NO'),
                        icon: const Icon(Icons.cancel),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
          const Padding(padding: EdgeInsets.only(bottom: 150.0)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
    planNumController.dispose();
  }
}
