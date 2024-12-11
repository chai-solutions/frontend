import 'package:chai/app/screens/about.dart';
import 'package:chai/app/screens/create_account.dart';
import 'package:chai/app/screens/home.dart';
import 'package:chai/app/screens/login.dart';
import 'package:chai/app/screens/settings.dart';
import 'package:chai/app/screens/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chai/app/screens/search/search_home.dart';
import 'package:chai/app/screens/search/search_by_flight_num.dart';
import 'package:chai/app/screens/search/search_by_airport.dart';
import 'package:chai/app/screens/view_plan.dart';
import 'package:chai/app/screens/edit_plan_home.dart';
import 'package:chai/app/screens/search/search_first_home.dart';
import 'package:chai/app/screens/search/search_first_by_flight_num.dart';
import 'package:chai/app/screens/search/search_first_by_airport.dart';
import 'package:chai/app/screens/add_flight/add_by_airport.dart';
import 'package:chai/app/screens/add_flight/add_by_flight_name.dart';
import 'package:chai/app/screens/flight_info.dart';

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
        path: '/viewFlightPlan/:planId',
        builder: (context, state) {
          final planID = int.parse(state.pathParameters['planId'] ?? '');

          return ViewFlightPlan(planID: planID);
        },
      ),
      GoRoute(
        path: '/editPlanHome/:planId',
        builder: (context, state) {
          final planIdString = state.pathParameters['planId'];
          final planId = int.tryParse(planIdString ?? '');
          return EditPlanHome(inputPlanId: planId);
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
      GoRoute(
        path: '/addByFlightNum/:planId',
        builder: (context, state) {
          final planIdString = state.pathParameters['planId'];
          final planId = int.tryParse(planIdString ?? '');
          return AddByFlightNum(inputPlanId: planId);
        },
      ),
      GoRoute(
        path: '/addByAirport/:planId',
        builder: (context, state) {
          final planIdString = state.pathParameters['planId'];
          final planId = int.tryParse(planIdString ?? '');
          return AddByAirport(inputPlanId: planId);
        },
      ),
      GoRoute(
        path: '/flightInfo/:planId/:flightIndex',
        builder: (context, state) {
          final planIdString = state.pathParameters['planId'];
          final flightIndexString = state.pathParameters['flightIndex'];

          final planId = int.parse(planIdString ?? '');
          final flightIndex = int.parse(flightIndexString ?? '');

          return FlightInfo(planID: planId, stepID: flightIndex);
        },
      ),
    ],
  );
}
