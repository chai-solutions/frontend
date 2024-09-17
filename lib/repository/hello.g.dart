// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hello.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getHelloHash() => r'926eb5fecb1e89868458d8fa863652c6748f8318';

/// See also [getHello].
@ProviderFor(getHello)
final getHelloProvider = AutoDisposeFutureProvider<HelloResponse>.internal(
  getHello,
  name: r'getHelloProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getHelloHash,
  dependencies: <ProviderOrFamily>[httpClientProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    httpClientProvider,
    ...?httpClientProvider.allTransitiveDependencies
  },
);

typedef GetHelloRef = AutoDisposeFutureProviderRef<HelloResponse>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
