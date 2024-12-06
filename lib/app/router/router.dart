import 'package:chai/app/screens/add_trip.dart';
import 'package:chai/app/screens/about.dart';
import 'package:chai/app/screens/create_account.dart';
import 'package:chai/app/screens/home.dart';
import 'package:chai/app/screens/login.dart';
import 'package:chai/app/screens/settings.dart';
import 'package:chai/app/screens/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chai/app/screens/searchHome.dart';
import 'package:chai/app/screens/searchByFlightNum.dart';
import 'package:chai/app/screens/searchByAirport.dart';
import 'package:chai/app/screens/addPlan.dart';
import 'package:chai/app/screens/addDeleteFlight.dart';
import 'package:chai/app/screens/choosePlan.dart';
import 'package:chai/app/screens/areYouSure.dart';
import 'package:chai/app/screens/searchFirstHome.dart';
import 'package:chai/app/screens/searchFirstByFlightNum.dart';
import 'package:chai/app/screens/searchFirstByAirport.dart';

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
          return HomePage();
        },
      ),
      GoRoute(
        path: '/add-trip',
        builder: (context, state) {
          return const AddTripPage();
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) {
          return const Settings();
        },
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) {
          return const AboutPage();
        },
      ),
      GoRoute(
        path: '/searchHome',
        builder: (context, state) {
          return const SearchHomeScreen();
        },
      ),
      GoRoute(
        path: '/searchByFlightNum',
        builder: (context, state) {
          return const SearchByFlightNum();
        },
      ),
      GoRoute(
        path: '/searchByAirport',
        builder: (context, state) {
          return const SearchByAirport();
        },
      ),
      GoRoute(
        path: '/addPlan',
        builder: (context, state) {
          return const AddPlan();
        },
      ),
      GoRoute(
        path: '/addDeleteFlight',
        builder: (context, state) {
          return const AddDeleteFlight();
        },
      ),
      GoRoute(
        path: '/choosePlan',
        builder: (context, state) {
          return const ChoosePlan();
        },
      ),
      GoRoute(
        path: '/areYouSure',
        builder: (context, state) {
          return const AreYouSure();
        },
      ),
      GoRoute(
        path: '/searchFirstHome',
        builder: (context, state) {
          return const SearchFirstHomeScreen();
        },
      ),
      GoRoute(
        path: '/searchFirstByFlightNum',
        builder: (context, state) {
          return const SearchFirstByFlightNum();
        },
      ),
      GoRoute(
        path: '/searchFirstByAirport',
        builder: (context, state) {
          return const SearchFirstByAirport();
        },
      ),
    ],
  );
}
