import 'package:chai/app/widgets/toasts.dart';
import 'package:chai/controllers/auth.dart';
import 'package:chai/models/models.dart';
import 'package:chai/providers/package_info.dart';
import 'package:chai/repository/hello.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chai Solutions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final AsyncValue<HelloResponse> res =
                    ref.watch(getHelloProvider);

                return switch (res) {
                  AsyncData(:final value) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.message,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Your random number is: ${value.number}'),
                      ],
                    ),
                  AsyncError() => const Text('something went wrong'),
                  _ => const CircularProgressIndicator(),
                };
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final AsyncValue<PackageInfo> packageInfo =
                    ref.watch(packageInfoProvider);

                return switch (packageInfo) {
                  AsyncData(:final value) => Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Version: ${value.version}+${value.buildNumber}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
            ElevatedButton(
              onPressed: () {
                infoToast(
                  context: context,
                  title: "Success!",
                  message: "This is a test notification.",
                  icon: const Icon(Icons.flutter_dash),
                );
              },
              child: const Text('Toast me.'),
            ),
            Consumer(builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () async {
                  final authController =
                      ref.read(authControllerProvider.notifier);
                  await authController.logout();
                  if (context.mounted) {
                    context.replace('/login');
                  }
                },
                child: const Text('Logout'),
              );
            })
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final res = ref.watch(getHelloProvider);

          if (res.isRefreshing) {
            return FloatingActionButton(
              onPressed: () {},
              tooltip: 'Refreshing...',
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            );
          }

          return FloatingActionButton(
            onPressed: () => ref.refresh(getHelloProvider),
            tooltip: 'Increment',
            child: const Icon(Icons.refresh),
          );
        },
      ),
    );
  }
}
