import 'package:chai/app/router/router.dart';
import 'package:chai/app/theme.dart';
import 'package:chai/utils/env.dart';
import 'package:chai/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

void main() async {
  await Env.init();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      observers: [
        TalkerRiverpodObserver(talker: logger),
      ],
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Chai',
      theme: GlobalThemeData.defaultTheme,
      routerConfig: router,
    );
  }
}
