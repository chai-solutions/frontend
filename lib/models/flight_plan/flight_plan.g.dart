// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlightPlanImpl _$$FlightPlanImplFromJson(Map<String, dynamic> json) =>
    _$FlightPlanImpl(
      id: (json['flight_plan_id'] as num).toInt(),
      indvFlightId: (json['indv_flight_id'] as num).toInt(),
      flightNumber: json['flight_number'] as String,
      departureAirportName: json['dep_airport'] as String,
      departureAirportCode: json['iata'] as String,
      arrivalAirportName: json['arr_airport'] as String,
      arrivalAirportCode: json['iata_2'] as String,
      scheduledDepartureTime: DateTime.parse(json['sched_dep_time'] as String),
      arrivalAirportTime: DateTime.parse(json['sched_arr_time'] as String),
      actualDepartureTime: DateTime.parse(json['actual_dep_time'] as String),
      actualArrivalTime: DateTime.parse(json['actual_arr_time'] as String),
    );

Map<String, dynamic> _$$FlightPlanImplToJson(_$FlightPlanImpl instance) =>
    <String, dynamic>{
      'flight_plan_id': instance.id,
      'indv_flight_id': instance.indvFlightId,
      'flight_number': instance.flightNumber,
      'dep_airport': instance.departureAirportName,
      'iata': instance.departureAirportCode,
      'arr_airport': instance.arrivalAirportName,
      'iata_2': instance.arrivalAirportCode,
      'sched_dep_time': instance.scheduledDepartureTime.toIso8601String(),
      'sched_arr_time': instance.arrivalAirportTime.toIso8601String(),
      'actual_dep_time': instance.actualDepartureTime.toIso8601String(),
      'actual_arr_time': instance.actualArrivalTime.toIso8601String(),
    };

_$FlightPlanListImpl _$$FlightPlanListImplFromJson(Map<String, dynamic> json) =>
    _$FlightPlanListImpl(
      flightPlanList: (json['flightPlanList'] as List<dynamic>)
          .map((e) => FlightPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FlightPlanListImplToJson(
        _$FlightPlanListImpl instance) =>
    <String, dynamic>{
      'flightPlanList': instance.flightPlanList,
    };
