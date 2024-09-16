import 'package:chai/app/router/router.dart';
import 'package:chai/app/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
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
