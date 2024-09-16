import 'package:chai/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:chai/app/screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chai',
      theme: GlobalThemeData.defaultTheme,
      home: const HomePage(title: 'Chai Solutions'),
    );
  }
}
