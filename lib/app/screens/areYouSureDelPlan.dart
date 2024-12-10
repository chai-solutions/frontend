import 'package:chai/app/widgets/buttons.dart';
import 'package:chai/app/widgets/toasts.dart';
import 'package:chai/controllers/auth.dart';
import 'package:chai/models/flight_plan/flight_plan.dart';
import 'package:chai/repository/flight_plan.dart';
import 'package:chai/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:chai/providers/http_client.dart';
import 'package:chai/utils/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:math';

final myController = TextEditingController();
final planNumController = TextEditingController();

class AreYouSureDelPlan extends ConsumerStatefulWidget {
  final int? inputPlanId;
  const AreYouSureDelPlan({Key? key, required this.inputPlanId})
      : super(key: key);
  get planId => inputPlanId; //gets flight plan number for this page
  @override
  _AreYouSureDelPlanState createState() => _AreYouSureDelPlanState();
}

class _AreYouSureDelPlanState extends ConsumerState<AreYouSureDelPlan> {
  int? get planId => widget.inputPlanId;
  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>?> deleteFlightPlan(int? flightNum) async {
      final baseURL = Env().baseURL;
      try {
        print('searchFlightNum: $flightNum');
        //authorize query
        final client = ref.read(httpClientProvider);
        //submit query
        final response = await client.delete('/flight_plans/$planId');
        final statusCode = response.statusCode;
        //flight found
        if (statusCode == 204) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          setState(() {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
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
          print('Failed to delete plan. Status code: $statusCode');
          setState(() {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(
                    'Could not add flight to flight plan. \nInvalid flight code.'),
              ),
            );
          });
        }
      } catch (error) {
        print("Invalid Flight Code");
      }
    }

    final user = ref.watch(currentUserProvider);
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
                final authController =
                    ref.read(authControllerProvider.notifier);
                if (context.mounted) {
                  context.go('/addDeleteFlight/${planId}');
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
                padding: EdgeInsets.only(bottom: 300.0),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        double maxWidth = constraints.maxWidth * 0.7;
                        return SizedBox(
                          width: maxWidth,
                          child: Text(
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
                    Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 75.0,
                      ),
                      //button to delete current flight plan, then go home
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final authController =
                              ref.read(authControllerProvider.notifier);
                          final flightData = await deleteFlightPlan(planId);
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
                          final authController =
                              ref.read(authControllerProvider.notifier);
                          if (context.mounted) {
                            context.go('/addDeleteFlight/${planId}');
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
          Padding(padding: EdgeInsets.only(bottom: 150.0)),
        ],
      ),
    );
  }
}
