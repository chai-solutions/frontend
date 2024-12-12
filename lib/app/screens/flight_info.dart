import 'package:chai/app/widgets/main_page_scaffold.dart';
import 'package:chai/app/widgets/toasts.dart';
import 'package:chai/providers/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:chai/models/flight_plan/flight_plan.dart';
import 'package:chai/repository/flight_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FlightInfo extends ConsumerWidget {
  final int planID;
  final int stepID;

  const FlightInfo({
    super.key,
    required this.planID,
    required this.stepID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flightPlans = ref.watch(flightPlanListProvider);

    return MainPageScaffold(
      title: flightPlans.maybeWhen(
        data: (d) {
          final index = d.indexWhere((plan) => plan.id == planID);
          if (index == -1) {
            return '';
          }

          final plan = d[index];
          final departingAirport = plan.departureAirportCode;
          final arrivalAirport = plan.arrivalAirportCode;

          return '$departingAirport -> $arrivalAirport';
        },
        orElse: () => null,
      ),
      child: flightPlans.when(
        data: (d) {
          final index = d.indexWhere((plan) => plan.id == planID);
          if (index == -1) {
            return _nonexistentPlan();
          }

          return FlightStepInfo(planID: planID, stepID: stepID, plan: d[index]);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red),
                Text('An error has occurred.',
                    style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nonexistentPlan() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red),
          Text(
            "This plan doesn't exist.",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class FlightStepInfo extends ConsumerWidget {
  final int planID;
  final int stepID;
  final FlightPlan plan;

  const FlightStepInfo({
    super.key,
    required this.plan,
    required this.planID,
    required this.stepID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        _planCard(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.circular(8.0), // Adjust radius as needed
                ),
                child: TextButton(
                  onPressed: () {
                    _confirmDelete(context, ref);
                  },
                  child: const Text(
                    'Delete Flight',
                    style: TextStyle(
                        color: Colors.white), // Text color for contrast
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> deleteFlightFromPlan(BuildContext context, WidgetRef ref) async {
    try {
      final client = ref.read(httpClientProvider);
      final response = await client.delete('/flight_plans/$planID/$stepID');

      if (response.statusCode == 204) {
        infoToast(
          // ignore: use_build_context_synchronously
          context: context,
          title: 'Success!',
          message: 'Flight has been deleted from the plan.',
        );
        // ignore: use_build_context_synchronously
        context.go('/home');
        ref.invalidate(flightPlanListProvider);
      } else {
        errorToast(
          // ignore: use_build_context_synchronously
          context: context,
          title: 'Something went wrong.',
          message: 'An error was encountered while deleting the flight.',
        );
      }
    } catch (error) {
      // Invalid flight code
    }
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Confirm'),
        content: const Text(
            'Do you really want to delete this flight from the plan?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              deleteFlightFromPlan(context, ref);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Widget _planCard() {
    final startDate =
        DateFormat.yMMMMd('en_US').format(plan.scheduledDepartureTime);
    final departureTime =
        DateFormat.Hm('en_US').format(plan.scheduledDepartureTime);

    return Card(
      color: const Color.fromARGB(255, 86, 105, 114),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(
            "Flight Number: ${plan.flightNumber.toString()}\nDate Of Flight: $startDate\n\nFROM: ${plan.departureAirportName}\n\nTO: ${plan.arrivalAirportName}\n\nFlight departs at $departureTime"),
        subtitle: const Text(''),
      ),
    );
  }
}
