import 'package:chai/models/models.dart';
import 'package:chai/repository/hello.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        child: Consumer(builder: (context, ref, child) {
          final AsyncValue<HelloResponse> res = ref.watch(getHelloProvider);

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
        }),
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
