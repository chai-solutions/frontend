import 'package:chai/app/router/router.dart';
import 'package:chai/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chai',
      theme: GlobalThemeData.defaultTheme,
      routerConfig: router,
    );
  }
}
