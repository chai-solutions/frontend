import 'package:chai/app/widgets/buttons.dart';
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

class ViewFlightPlan extends ConsumerWidget {
  final int planID;

  const ViewFlightPlan({super.key, required this.planID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flightPlans = ref.watch(flightPlanListProvider);

    return MainPageScaffold(
      title: 'Flight Plan',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GSButton(
                  onPressed: () {
                    context.go('/editPlanHome/$planID');
                  },
                  text: 'Add Flight',
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        BorderRadius.circular(8.0), // Adjust radius as needed
                  ),
                  child: TextButton(
                    onPressed: () {
                      _confirmDeletion(context, ref);
                    },
                    child: const Text(
                      'Permanently Delete Plan',
                      style: TextStyle(
                          color: Colors.white), // Text color for contrast
                    ),
                  ),
                ),
              ],
            ),
          ),
          flightPlans.when(
            data: (d) => _stepList(d),
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
        ],
      ),
    );
  }

  void _confirmDeletion(BuildContext context, WidgetRef ref) {
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
              _deleteFlightPlan(context, ref);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteFlightPlan(BuildContext context, WidgetRef ref) async {
    try {
      final client = ref.read(httpClientProvider);
      final response = await client.delete('/flight_plans/$planID');

      if (response.statusCode == 204) {
        infoToast(
          // ignore: use_build_context_synchronously
          context: context,
          title: 'Success!',
          message: 'Plan has been deleted',
        );
        // ignore: use_build_context_synchronously
        context.go('/home');
        ref.invalidate(flightPlanListProvider);
      } else {
        throw Exception('request not good oops');
      }
    } catch (error) {
      errorToast(
        // ignore: use_build_context_synchronously
        context: context,
        title: 'Something went wrong.',
        message: 'An error was encountered while deleting this flight plan.',
      );
    }
  }

  Widget _stepList(List<FlightPlan> plans) {
    if (plans.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('No flight plans have been made.'),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        //filters out flights from other plans
        itemCount: plans.length,

        itemBuilder: (context, index) {
          final step = plans[index];

          final startDate =
              DateFormat.yMMMMd('en_US').format(step.scheduledDepartureTime);
          final departureTime =
              DateFormat.Hm('en_US').format(step.scheduledDepartureTime);

          //makes cards clickable for moe info
          return InkWell(
            onTap: () {
              context
                  .push('/flightInfo/${step.id}/${plans[index].indvFlightId}');
            },
            child: Card(
              color: const Color.fromARGB(255, 86, 105, 114),
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                title: Text("${step.flightNumber}\n$startDate"),
                subtitle: Text(
                    '${step.departureAirportCode} -> ${step.arrivalAirportCode} @ $departureTime'),
                trailing: const Icon(Icons.info),
              ),
            ),
          );
        },
      ),
    );
  }
}
