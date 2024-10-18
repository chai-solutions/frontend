// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_plan.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$flightPlanRepoHash() => r'ae4d58bf641668e76a181539cba657d33283a5ef';

/// See also [flightPlanRepo].
@ProviderFor(flightPlanRepo)
final flightPlanRepoProvider =
    AutoDisposeProvider<FlightPlanRepository>.internal(
  flightPlanRepo,
  name: r'flightPlanRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flightPlanRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FlightPlanRepoRef = AutoDisposeProviderRef<FlightPlanRepository>;
String _$flightPlanListHash() => r'727e55271e5042fdfba21f1e14457691eebffa2c';

/// See also [flightPlanList].
@ProviderFor(flightPlanList)
final flightPlanListProvider =
    AutoDisposeFutureProvider<List<FlightPlan>>.internal(
  flightPlanList,
  name: r'flightPlanListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flightPlanListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FlightPlanListRef = AutoDisposeFutureProviderRef<List<FlightPlan>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
