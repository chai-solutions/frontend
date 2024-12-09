import 'package:chai/app/widgets/buttons.dart';
import 'package:chai/app/widgets/main_page_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:chai/controllers/auth.dart';
import 'package:chai/models/flight_plan/flight_plan.dart';
import 'package:chai/providers/onesignal.dart';
import 'package:chai/repository/flight_plan.dart';
import 'package:chai/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FlightInfo extends ConsumerStatefulWidget {
  final int? inputPlanId;
  final int? inputFlightIndex;

  const FlightInfo(
      {Key? key, required this.inputPlanId, required this.inputFlightIndex})
      : super(key: key);

  //gets flight plan number for this page
  get inputFlightId => inputPlanId;
  //get index of individual flight in flight plan
  get inputPlanIndex => inputFlightIndex;

  @override
  ConsumerState<FlightInfo> createState() => FlightInfoState();
}

int planId = 0;
int planIndex = 0;

class FlightInfoState extends ConsumerState<FlightInfo> {
  FlightInfoState();
  @override
  void initState() {
    super.initState();
    final oneSignalService = ref.read(oneSignalServiceProvider);
    oneSignalService.requestPermission();
    planId = widget.inputPlanId!; //sets this screen's current flight plan
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final fullName = user.whenOrNull(data: (u) => u.name);
    final name = fullName?.split(' ').elementAt(0);
    planId = widget.inputFlightId;
    planIndex = widget.inputFlightIndex! + 1;
    return MainPageScaffold(
      title:
          name != null ? 'Flight Plan ${planId}\nFlight #${planIndex}' : null,
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
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
                  label: const Text('Back To Plan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Set the background color to white
                  ),
                ),
              ),
            ],
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
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8.0), // Adjust radius as needed
          ),
          child: TextButton(
            onPressed: () {
              context.go('/areYouSureDelFlight/$planId/$planIndex');
            },
            child: Text(
              'Permanently Delete This Flgiht From Plan',
              style: TextStyle(color: Colors.white), // Text color for contrast
            ),
          ),
        )
      ],
    );
  }

  Widget _planList(List<FlightPlan> plans) {
    if (plans.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('No flight plans have been made.'),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        //single out specific desired flight
        itemCount: 1,
        itemBuilder: (context, index) {
          final filteredPlans =
              plans.where((plan) => plan.id == planId).toList()[planIndex - 1];
          final plan = filteredPlans;
          final startDate =
              DateFormat.yMMMMd('en_US').format(plan.scheduledDepartureTime);
          final departureTime =
              DateFormat.Hm('en_US').format(plan.scheduledDepartureTime);

          //makes cards clickable for deletion?
          return InkWell(
            onTap: () {},
            child: Card(
              color: const Color.fromARGB(255, 86, 105, 114),
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                title: Text(
                    "Flight Number: ${plan.flightNumber.toString()}\nDate Of Flight: ${startDate}\n\nFROM: ${plan.departureAirportName}\n\nTO: ${plan.arrivalAirportName}\n\nFlight departs at $departureTime"),
                subtitle: Text(''),
              ),
            ),
          );
        },
      ),
    );
  }
}
