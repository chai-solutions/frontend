import 'dart:convert';

import 'package:chai/models/models.dart';
import 'package:chai/providers/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flight_plan.g.dart';

class FlightPlanRepository {
  final HttpClient client;

  FlightPlanRepository(this.client);

  Future<List<FlightPlan>> getFlightPlans() async {
    final res = await client.get('/flight_plans');

    if (res.statusCode != 200) {
      throw Exception('Internal server error. Try again later.');
    }

    // Right now, the body is empty instead of returning 404
    // for nonexistent IDs.
    if (res.body.isEmpty) {
      throw Exception('Flight plan not found');
    }

    if (res.body == "null\n") {
      return [];
    }

    final json = jsonDecode(res.body) as List<dynamic>;
    return FlightPlanList.fromJson({'flightPlanList': json}).flightPlanList;
  }
}

@riverpod
FlightPlanRepository flightPlanRepo(FlightPlanRepoRef ref) {
  final client = ref.watch(httpClientProvider);
  final repo = FlightPlanRepository(client);
  return repo;
}

@riverpod
Future<List<FlightPlan>> flightPlanList(FlightPlanListRef ref) async {
  final flightPlanRepo = ref.watch(flightPlanRepoProvider);
  return flightPlanRepo.getFlightPlans();
}
