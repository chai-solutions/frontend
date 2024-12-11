import 'package:flutter/material.dart';
import 'package:chai/providers/http_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

class AreYouSureDelFlight extends ConsumerStatefulWidget {
  final int? inputPlanId;
  final int? inputFlightIndex;
  final int? inputFlightId;

  const AreYouSureDelFlight(
      {super.key,
      required this.inputPlanId,
      required this.inputFlightIndex,
      required this.inputFlightId});

  @override
  ConsumerState<AreYouSureDelFlight> createState() =>
      _AreYouSureDelFlightState();
}

int planId = 0;
int flightId = 0;

class _AreYouSureDelFlightState extends ConsumerState<AreYouSureDelFlight> {
  //IMPORTANT NOTE: SOMEHOW THE DEFINITIONS OF FLIGHT INDEX AND FLIGHT ID GOT SWAPPED
  int? get planId => widget.inputPlanId;
  int? get flightIndex => widget.inputFlightIndex;
  int? get flightId => widget.inputFlightId;
  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>?> deleteFlightPlan(int? flightNum) async {
      try {
        //authorize query
        final client = ref.read(httpClientProvider);
        //submit query
        final response =
            await client.delete('/flight_plans/$planId/$flightIndex');
        final statusCode = response.statusCode;
        //flight found
        if (statusCode == 204) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          setState(() {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Success!'),
                content: Text('Deleted flight from plan.'),
              ),
            );
            if (context.mounted) {
              context.go('/addDeleteFlight/$planId');
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
        // Invalid flight code
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
            //button to go back to flight info
            child: ElevatedButton.icon(
              onPressed: () async {
                if (context.mounted) {
                  context.go('/flightInfo/$planId/$flightId');
                }
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back To Flight Info'),
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
                          child: Text(
                            'Are you sure you want to permanently delete this flight from plan $planId?',
                            style: const TextStyle(
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
                          await deleteFlightPlan(planId);
                          if (context.mounted) {
                            context.go('/addDeleteFlight/$planId');
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
                            context.go('/flightInfo/$planId/$flightId');
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
}
