import 'package:chai/app/widgets/buttons.dart';
import 'package:chai/app/widgets/toasts.dart';
import 'package:chai/controllers/auth.dart';
import 'package:chai/models/flight_plan/flight_plan.dart';
import 'package:chai/repository/flight_plan.dart';
import 'package:chai/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                    child: Stack(
                      children: [
                        // Title message in the center
                        Positioned(
                          left: 16.0,
                          bottom: 16.0,
                          // child:
                          child: user.maybeWhen(
                            data: (u) {
                              return Text(
                                'Welcome, ${u.name}!',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                            orElse: () => const SizedBox.shrink(),
                          ),
                        ),
                        // Notifications icon and circular image at the top right
                        Positioned(
                          right: 16.0,
                          top: 16.0,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                              const SizedBox(width: 8.0),
                              CircleAvatar(
                                backgroundColor:
                                    user.hasValue ? null : Colors.grey,
                                backgroundImage: user.maybeWhen(
                                  data: (u) {
                                    final component =
                                        Uri.encodeComponent(u.name);
                                    return NetworkImage(
                                        "https://ui-avatars.com/api/?name=$component");
                                  },
                                  orElse: () => null,
                                ),
                                radius: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: const FlightPlanList(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 1, left: 16),
          child: Text(
            'My Trips',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
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
        //button will bring user to screen where user can search for flights
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () async {
              final authController = ref.read(authControllerProvider.notifier);
              if (context.mounted) {
                context.go('/searchHome');
              }
            },
            icon: const Icon(Icons.search),
            label: const Text(
                style: TextStyle(fontWeight: FontWeight.bold), 'Search Flight'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 19, 143, 194),
              iconColor: Colors.white,
              foregroundColor: Colors.white,
            ),
          ),
        ),

        // Row of buttons at the bottom
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GSButton(
                onPressed: () {
                  warningToast(
                    context: context,
                    title: 'Unimplemented',
                    message: "We'll get around to this soon!",
                  );
                },
                text: 'Add Plan',
              ),
              GSButton(
                onPressed: () async {
                  final authController =
                      ref.read(authControllerProvider.notifier);
                  await authController.logout();
                  if (context.mounted) {
                    context.replace('/login');
                  }
                },
                text: 'Logout',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _planList(List<FlightPlan> plans) {
    if (plans.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            'No flight plans have been made.',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          final startDate =
              DateFormat.yMMMMd('en_US').format(plan.scheduledDepartureTime);
          final departureTime =
              DateFormat.Hm('en_US').format(plan.scheduledDepartureTime);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(startDate),
              subtitle: Text(
                  '${plan.departureAirportCode} -> ${plan.arrivalAirportCode} @ $departureTime'),
              trailing: const Icon(Icons.arrow_forward),
            ),
          );
        },
      ),
    );
  }
}
