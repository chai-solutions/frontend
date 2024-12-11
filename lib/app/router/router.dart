import 'package:chai/app/screens/add_trip.dart';
import 'package:chai/app/screens/about.dart';
import 'package:chai/app/screens/create_account.dart';
import 'package:chai/app/screens/home.dart';
import 'package:chai/app/screens/login.dart';
import 'package:chai/app/screens/notifications.dart';
import 'package:chai/app/screens/settings.dart';
import 'package:chai/app/screens/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chai/app/screens/search/search_home.dart';
import 'package:chai/app/screens/search/search_by_flight_num.dart';
import 'package:chai/app/screens/search/search_by_airport.dart';
import 'package:chai/app/screens/add_plan/add_plan.dart';
import 'package:chai/app/screens/add_plan/add_delete_flight.dart';
import 'package:chai/app/screens/edit_plan_home.dart';
import 'package:chai/app/screens/are_you_sure.dart';
import 'package:chai/app/screens/search/search_first_home.dart';
import 'package:chai/app/screens/search/search_first_by_flight_num.dart';
import 'package:chai/app/screens/search/search_first_by_airport.dart';
import 'package:chai/app/screens/delete_plan.dart';
import 'package:chai/app/screens/add_plan/add_by_airport.dart';
import 'package:chai/app/screens/add_plan/add_by_flight_name.dart';
import 'package:chai/app/screens/are_you_sure_del_plan.dart';
import 'package:chai/app/screens/flight_info.dart';
import 'package:chai/app/screens/are_you_sure_del_flight.dart';

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
        path: '/notifications',
        builder: (context, state) {
          return const Notifications();
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
          return AddPlan();
        },
      ),
      GoRoute(
        path: '/addDeleteFlight/:planId',
        builder: (context, state) {
          final planIdString = state.pathParameters['planId'];
          final planId = int.tryParse(planIdString ?? '');
          return AddDeleteFlight(inputPlanId: planId);
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
        path: '/deletePlan/:planId',
        builder: (context, state) {
          final planIdString = state.pathParameters['planId'];
          final planId = int.tryParse(planIdString ?? '');
          return DeletePlan(inputPlanId: planId);
        },
      ),
      GoRoute(
        path: '/areYouSure',
        builder: (context, state) {
          return AreYouSure();
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
        path: '/areYouSureDelPlan/:planId',
        builder: (context, state) {
          final planIdString = state.pathParameters['planId'];
          final planId = int.tryParse(planIdString ?? '');
          return AreYouSureDelPlan(inputPlanId: planId);
        },
      ),
      GoRoute(
        path: '/flightInfo/:planId/:flightIndex',
        builder: (context, state) {
          final planIdString = state.pathParameters['planId'];
          final flightIndexString = state.pathParameters['flightIndex'];
          final planId = int.tryParse(planIdString ?? '');
          final flightIndex = int.tryParse(flightIndexString ?? '');
          return FlightInfo(inputPlanId: planId, inputFlightIndex: flightIndex);
        },
      ),
      GoRoute(
        path: '/areYouSureDelFlight/:planId/:flightIndex/:flightId',
        builder: (context, state) {
          final planIdString = state.pathParameters['planId'];
          final flightIndexString = state.pathParameters['flightIndex'];
          final flightIdString = state.pathParameters['flightId'];
          final planId = int.tryParse(planIdString ?? '');
          final flightIndex = int.tryParse(flightIndexString ?? '');
          final flightId = int.tryParse(flightIdString ?? '');
          return AreYouSureDelFlight(
            inputPlanId: planId,
            inputFlightIndex: flightIndex,
            inputFlightId: flightId,
          );
        },
      )
    ],
  );
}
