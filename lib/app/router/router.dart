import 'package:chai/app/screens/create_account.dart';
import 'package:chai/app/screens/home.dart';
import 'package:chai/app/screens/login.dart';
import 'package:chai/app/screens/settings.dart';
import 'package:chai/app/screens/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/create-account',
        builder: (context, state) {
          return const CreateAccountScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) {
          return const Settings();
        },
      )
    ],
  );
}
