import 'package:chai/app/router/router.dart';
import 'package:chai/app/theme.dart';
import 'package:chai/providers/onesignal.dart';
import 'package:chai/utils/env.dart';
import 'package:chai/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

void main() async {
  await Env.init();

  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.initialize(Env().onesignalAppID);
  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    event.notification.display();
  });

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
    ref.watch(oneSignalListenerProvider);

    return MaterialApp.router(
      title: 'Chai',
      theme: GlobalThemeData.defaultTheme,
      routerConfig: router,
    );
  }
}
