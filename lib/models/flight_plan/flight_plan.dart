import 'package:freezed_annotation/freezed_annotation.dart';

part 'flight_plan.freezed.dart';
part 'flight_plan.g.dart';

@freezed
class FlightPlan with _$FlightPlan {
  factory FlightPlan({
    @JsonKey(name: 'flight_plan_id') required int id,
    @JsonKey(name: 'indv_flight_id') required int indvFlightId,
    @JsonKey(name: 'flight_number') required String flightNumber,
    @JsonKey(name: 'dep_airport') required String departureAirportName,
    @JsonKey(name: 'iata') required String departureAirportCode,
    @JsonKey(name: 'arr_airport') required String arrivalAirportName,
    @JsonKey(name: 'iata_2') required String arrivalAirportCode,
    @JsonKey(name: 'sched_dep_time') required DateTime scheduledDepartureTime,
    @JsonKey(name: 'sched_arr_time') required DateTime arrivalAirportTime,
    @JsonKey(name: 'actual_dep_time') required DateTime actualDepartureTime,
    @JsonKey(name: 'actual_arr_time') required DateTime actualArrivalTime,
  }) = _FlightPlan;

  factory FlightPlan.fromJson(Map<String, dynamic> json) =>
      _$FlightPlanFromJson(json);
}

@freezed
abstract class FlightPlanList with _$FlightPlanList {
  const factory FlightPlanList({
    required List<FlightPlan> flightPlanList,
  }) = _FlightPlanList;

  factory FlightPlanList.fromJson(Map<String, dynamic> json) =>
      _$FlightPlanListFromJson(json);
}
