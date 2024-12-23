import 'package:chai/app/widgets/buttons.dart';
import 'package:chai/app/widgets/main_page_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:chai/models/flight_plan/flight_plan.dart';
import 'package:chai/providers/onesignal.dart';
import 'package:chai/repository/flight_plan.dart';
import 'package:chai/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  HomePageState();

  @override
  void initState() {
    super.initState();
    final oneSignalService = ref.read(oneSignalServiceProvider);
    oneSignalService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final fullName = user.whenOrNull(data: (u) => u.name);
    final name = fullName?.split(' ').elementAt(0);

    return MainPageScaffold(
      title: name != null ? 'Welcome, $name!' : null,
      enableBackButton: false,
      child: const FlightPlanList(),
    );
  }
}

class FlightPlanList extends ConsumerWidget {
  const FlightPlanList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flightPlans = ref.watch(flightPlanListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Trips',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GSButton(
                onPressed: () {
                  context.go('/searchFirstHome');
                },
                text: 'Create New Plan',
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            children: [],
          ),
        ),
        flightPlans.when(
          data: (d) => _planList(d),
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
    );
  }

  Widget _planList(List<FlightPlan> plans) {
    if (plans.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('No flight plans have been made.'),
          //checkPlans = checkPlans + 1;
        ),
      );
    }

    Set<int> uniquePlanIds = {};

    return Expanded(
      child: ListView.builder(
        itemCount: plans.where((plan) => uniquePlanIds.add(plan.id)).length,
        itemBuilder: (context, index) {
          final uniqueId = uniquePlanIds.elementAt(index);
          final plan = plans.firstWhere((plan) => plan.id == uniqueId);
          final departureTime =
              DateFormat.Hm('en_US').format(plan.scheduledDepartureTime);

          return InkWell(
            onTap: () {
              context.push('/viewFlightPlan/${plan.id}');
            },
            child: Card(
              color: const Color.fromARGB(255, 86, 105, 114),
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                title:
                    Text("Plan ID Number: ${plan.id}\nFirst Flight In Plan: "),
                subtitle: Text(
                    '${plan.departureAirportCode} -> ${plan.arrivalAirportCode} @ $departureTime'),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
          );
        },
      ),
    );
  }
}
