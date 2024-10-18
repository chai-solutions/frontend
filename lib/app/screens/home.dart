import 'package:chai/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
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
    return const Column(children: []);
  }
}
