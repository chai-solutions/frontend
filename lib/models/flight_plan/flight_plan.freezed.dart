// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flight_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FlightPlan _$FlightPlanFromJson(Map<String, dynamic> json) {
  return _FlightPlan.fromJson(json);
}

/// @nodoc
mixin _$FlightPlan {
  @JsonKey(name: 'flight_plan_id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'indv_flight_id')
  int get indvFlightId => throw _privateConstructorUsedError;
  @JsonKey(name: 'flight_number')
  String get flightNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'dep_airport')
  String get departureAirportName => throw _privateConstructorUsedError;
  @JsonKey(name: 'iata')
  String get departureAirportCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'arr_airport')
  String get arrivalAirportName => throw _privateConstructorUsedError;
  @JsonKey(name: 'iata_2')
  String get arrivalAirportCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'sched_dep_time')
  DateTime get scheduledDepartureTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'sched_arr_time')
  DateTime get arrivalAirportTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_dep_time')
  DateTime get actualDepartureTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_arr_time')
  DateTime get actualArrivalTime => throw _privateConstructorUsedError;

  /// Serializes this FlightPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlightPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlightPlanCopyWith<FlightPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlightPlanCopyWith<$Res> {
  factory $FlightPlanCopyWith(
          FlightPlan value, $Res Function(FlightPlan) then) =
      _$FlightPlanCopyWithImpl<$Res, FlightPlan>;
  @useResult
  $Res call(
      {@JsonKey(name: 'flight_plan_id') int id,
      @JsonKey(name: 'indv_flight_id') int indvFlightId,
      @JsonKey(name: 'flight_number') String flightNumber,
      @JsonKey(name: 'dep_airport') String departureAirportName,
      @JsonKey(name: 'iata') String departureAirportCode,
      @JsonKey(name: 'arr_airport') String arrivalAirportName,
      @JsonKey(name: 'iata_2') String arrivalAirportCode,
      @JsonKey(name: 'sched_dep_time') DateTime scheduledDepartureTime,
      @JsonKey(name: 'sched_arr_time') DateTime arrivalAirportTime,
      @JsonKey(name: 'actual_dep_time') DateTime actualDepartureTime,
      @JsonKey(name: 'actual_arr_time') DateTime actualArrivalTime});
}

/// @nodoc
class _$FlightPlanCopyWithImpl<$Res, $Val extends FlightPlan>
    implements $FlightPlanCopyWith<$Res> {
  _$FlightPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlightPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? indvFlightId = null,
    Object? flightNumber = null,
    Object? departureAirportName = null,
    Object? departureAirportCode = null,
    Object? arrivalAirportName = null,
    Object? arrivalAirportCode = null,
    Object? scheduledDepartureTime = null,
    Object? arrivalAirportTime = null,
    Object? actualDepartureTime = null,
    Object? actualArrivalTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      indvFlightId: null == indvFlightId
          ? _value.indvFlightId
          : indvFlightId // ignore: cast_nullable_to_non_nullable
              as int,
      flightNumber: null == flightNumber
          ? _value.flightNumber
          : flightNumber // ignore: cast_nullable_to_non_nullable
              as String,
      departureAirportName: null == departureAirportName
          ? _value.departureAirportName
          : departureAirportName // ignore: cast_nullable_to_non_nullable
              as String,
      departureAirportCode: null == departureAirportCode
          ? _value.departureAirportCode
          : departureAirportCode // ignore: cast_nullable_to_non_nullable
              as String,
      arrivalAirportName: null == arrivalAirportName
          ? _value.arrivalAirportName
          : arrivalAirportName // ignore: cast_nullable_to_non_nullable
              as String,
      arrivalAirportCode: null == arrivalAirportCode
          ? _value.arrivalAirportCode
          : arrivalAirportCode // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDepartureTime: null == scheduledDepartureTime
          ? _value.scheduledDepartureTime
          : scheduledDepartureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      arrivalAirportTime: null == arrivalAirportTime
          ? _value.arrivalAirportTime
          : arrivalAirportTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualDepartureTime: null == actualDepartureTime
          ? _value.actualDepartureTime
          : actualDepartureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualArrivalTime: null == actualArrivalTime
          ? _value.actualArrivalTime
          : actualArrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlightPlanImplCopyWith<$Res>
    implements $FlightPlanCopyWith<$Res> {
  factory _$$FlightPlanImplCopyWith(
          _$FlightPlanImpl value, $Res Function(_$FlightPlanImpl) then) =
      __$$FlightPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'flight_plan_id') int id,
      @JsonKey(name: 'indv_flight_id') int indvFlightId,
      @JsonKey(name: 'flight_number') String flightNumber,
      @JsonKey(name: 'dep_airport') String departureAirportName,
      @JsonKey(name: 'iata') String departureAirportCode,
      @JsonKey(name: 'arr_airport') String arrivalAirportName,
      @JsonKey(name: 'iata_2') String arrivalAirportCode,
      @JsonKey(name: 'sched_dep_time') DateTime scheduledDepartureTime,
      @JsonKey(name: 'sched_arr_time') DateTime arrivalAirportTime,
      @JsonKey(name: 'actual_dep_time') DateTime actualDepartureTime,
      @JsonKey(name: 'actual_arr_time') DateTime actualArrivalTime});
}

/// @nodoc
class __$$FlightPlanImplCopyWithImpl<$Res>
    extends _$FlightPlanCopyWithImpl<$Res, _$FlightPlanImpl>
    implements _$$FlightPlanImplCopyWith<$Res> {
  __$$FlightPlanImplCopyWithImpl(
      _$FlightPlanImpl _value, $Res Function(_$FlightPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlightPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? indvFlightId = null,
    Object? flightNumber = null,
    Object? departureAirportName = null,
    Object? departureAirportCode = null,
    Object? arrivalAirportName = null,
    Object? arrivalAirportCode = null,
    Object? scheduledDepartureTime = null,
    Object? arrivalAirportTime = null,
    Object? actualDepartureTime = null,
    Object? actualArrivalTime = null,
  }) {
    return _then(_$FlightPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      indvFlightId: null == indvFlightId
          ? _value.indvFlightId
          : indvFlightId // ignore: cast_nullable_to_non_nullable
              as int,
      flightNumber: null == flightNumber
          ? _value.flightNumber
          : flightNumber // ignore: cast_nullable_to_non_nullable
              as String,
      departureAirportName: null == departureAirportName
          ? _value.departureAirportName
          : departureAirportName // ignore: cast_nullable_to_non_nullable
              as String,
      departureAirportCode: null == departureAirportCode
          ? _value.departureAirportCode
          : departureAirportCode // ignore: cast_nullable_to_non_nullable
              as String,
      arrivalAirportName: null == arrivalAirportName
          ? _value.arrivalAirportName
          : arrivalAirportName // ignore: cast_nullable_to_non_nullable
              as String,
      arrivalAirportCode: null == arrivalAirportCode
          ? _value.arrivalAirportCode
          : arrivalAirportCode // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDepartureTime: null == scheduledDepartureTime
          ? _value.scheduledDepartureTime
          : scheduledDepartureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      arrivalAirportTime: null == arrivalAirportTime
          ? _value.arrivalAirportTime
          : arrivalAirportTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualDepartureTime: null == actualDepartureTime
          ? _value.actualDepartureTime
          : actualDepartureTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualArrivalTime: null == actualArrivalTime
          ? _value.actualArrivalTime
          : actualArrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FlightPlanImpl implements _FlightPlan {
  _$FlightPlanImpl(
      {@JsonKey(name: 'flight_plan_id') required this.id,
      @JsonKey(name: 'indv_flight_id') required this.indvFlightId,
      @JsonKey(name: 'flight_number') required this.flightNumber,
      @JsonKey(name: 'dep_airport') required this.departureAirportName,
      @JsonKey(name: 'iata') required this.departureAirportCode,
      @JsonKey(name: 'arr_airport') required this.arrivalAirportName,
      @JsonKey(name: 'iata_2') required this.arrivalAirportCode,
      @JsonKey(name: 'sched_dep_time') required this.scheduledDepartureTime,
      @JsonKey(name: 'sched_arr_time') required this.arrivalAirportTime,
      @JsonKey(name: 'actual_dep_time') required this.actualDepartureTime,
      @JsonKey(name: 'actual_arr_time') required this.actualArrivalTime});

  factory _$FlightPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlightPlanImplFromJson(json);

  @override
  @JsonKey(name: 'flight_plan_id')
  final int id;
  @override
  @JsonKey(name: 'indv_flight_id')
  final int indvFlightId;
  @override
  @JsonKey(name: 'flight_number')
  final String flightNumber;
  @override
  @JsonKey(name: 'dep_airport')
  final String departureAirportName;
  @override
  @JsonKey(name: 'iata')
  final String departureAirportCode;
  @override
  @JsonKey(name: 'arr_airport')
  final String arrivalAirportName;
  @override
  @JsonKey(name: 'iata_2')
  final String arrivalAirportCode;
  @override
  @JsonKey(name: 'sched_dep_time')
  final DateTime scheduledDepartureTime;
  @override
  @JsonKey(name: 'sched_arr_time')
  final DateTime arrivalAirportTime;
  @override
  @JsonKey(name: 'actual_dep_time')
  final DateTime actualDepartureTime;
  @override
  @JsonKey(name: 'actual_arr_time')
  final DateTime actualArrivalTime;

  @override
  String toString() {
    return 'FlightPlan(id: $id, indvFlightId: $indvFlightId, flightNumber: $flightNumber, departureAirportName: $departureAirportName, departureAirportCode: $departureAirportCode, arrivalAirportName: $arrivalAirportName, arrivalAirportCode: $arrivalAirportCode, scheduledDepartureTime: $scheduledDepartureTime, arrivalAirportTime: $arrivalAirportTime, actualDepartureTime: $actualDepartureTime, actualArrivalTime: $actualArrivalTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlightPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.indvFlightId, indvFlightId) ||
                other.indvFlightId == indvFlightId) &&
            (identical(other.flightNumber, flightNumber) ||
                other.flightNumber == flightNumber) &&
            (identical(other.departureAirportName, departureAirportName) ||
                other.departureAirportName == departureAirportName) &&
            (identical(other.departureAirportCode, departureAirportCode) ||
                other.departureAirportCode == departureAirportCode) &&
            (identical(other.arrivalAirportName, arrivalAirportName) ||
                other.arrivalAirportName == arrivalAirportName) &&
            (identical(other.arrivalAirportCode, arrivalAirportCode) ||
                other.arrivalAirportCode == arrivalAirportCode) &&
            (identical(other.scheduledDepartureTime, scheduledDepartureTime) ||
                other.scheduledDepartureTime == scheduledDepartureTime) &&
            (identical(other.arrivalAirportTime, arrivalAirportTime) ||
                other.arrivalAirportTime == arrivalAirportTime) &&
            (identical(other.actualDepartureTime, actualDepartureTime) ||
                other.actualDepartureTime == actualDepartureTime) &&
            (identical(other.actualArrivalTime, actualArrivalTime) ||
                other.actualArrivalTime == actualArrivalTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      indvFlightId,
      flightNumber,
      departureAirportName,
      departureAirportCode,
      arrivalAirportName,
      arrivalAirportCode,
      scheduledDepartureTime,
      arrivalAirportTime,
      actualDepartureTime,
      actualArrivalTime);

  /// Create a copy of FlightPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlightPlanImplCopyWith<_$FlightPlanImpl> get copyWith =>
      __$$FlightPlanImplCopyWithImpl<_$FlightPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlightPlanImplToJson(
      this,
    );
  }
}

abstract class _FlightPlan implements FlightPlan {
  factory _FlightPlan(
      {@JsonKey(name: 'flight_plan_id') required final int id,
      @JsonKey(name: 'indv_flight_id') required final int indvFlightId,
      @JsonKey(name: 'flight_number') required final String flightNumber,
      @JsonKey(name: 'dep_airport') required final String departureAirportName,
      @JsonKey(name: 'iata') required final String departureAirportCode,
      @JsonKey(name: 'arr_airport') required final String arrivalAirportName,
      @JsonKey(name: 'iata_2') required final String arrivalAirportCode,
      @JsonKey(name: 'sched_dep_time')
      required final DateTime scheduledDepartureTime,
      @JsonKey(name: 'sched_arr_time')
      required final DateTime arrivalAirportTime,
      @JsonKey(name: 'actual_dep_time')
      required final DateTime actualDepartureTime,
      @JsonKey(name: 'actual_arr_time')
      required final DateTime actualArrivalTime}) = _$FlightPlanImpl;

  factory _FlightPlan.fromJson(Map<String, dynamic> json) =
      _$FlightPlanImpl.fromJson;

  @override
  @JsonKey(name: 'flight_plan_id')
  int get id;
  @override
  @JsonKey(name: 'indv_flight_id')
  int get indvFlightId;
  @override
  @JsonKey(name: 'flight_number')
  String get flightNumber;
  @override
  @JsonKey(name: 'dep_airport')
  String get departureAirportName;
  @override
  @JsonKey(name: 'iata')
  String get departureAirportCode;
  @override
  @JsonKey(name: 'arr_airport')
  String get arrivalAirportName;
  @override
  @JsonKey(name: 'iata_2')
  String get arrivalAirportCode;
  @override
  @JsonKey(name: 'sched_dep_time')
  DateTime get scheduledDepartureTime;
  @override
  @JsonKey(name: 'sched_arr_time')
  DateTime get arrivalAirportTime;
  @override
  @JsonKey(name: 'actual_dep_time')
  DateTime get actualDepartureTime;
  @override
  @JsonKey(name: 'actual_arr_time')
  DateTime get actualArrivalTime;

  /// Create a copy of FlightPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlightPlanImplCopyWith<_$FlightPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FlightPlanList _$FlightPlanListFromJson(Map<String, dynamic> json) {
  return _FlightPlanList.fromJson(json);
}

/// @nodoc
mixin _$FlightPlanList {
  List<FlightPlan> get flightPlanList => throw _privateConstructorUsedError;

  /// Serializes this FlightPlanList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlightPlanList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlightPlanListCopyWith<FlightPlanList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlightPlanListCopyWith<$Res> {
  factory $FlightPlanListCopyWith(
          FlightPlanList value, $Res Function(FlightPlanList) then) =
      _$FlightPlanListCopyWithImpl<$Res, FlightPlanList>;
  @useResult
  $Res call({List<FlightPlan> flightPlanList});
}

/// @nodoc
class _$FlightPlanListCopyWithImpl<$Res, $Val extends FlightPlanList>
    implements $FlightPlanListCopyWith<$Res> {
  _$FlightPlanListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlightPlanList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flightPlanList = null,
  }) {
    return _then(_value.copyWith(
      flightPlanList: null == flightPlanList
          ? _value.flightPlanList
          : flightPlanList // ignore: cast_nullable_to_non_nullable
              as List<FlightPlan>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlightPlanListImplCopyWith<$Res>
    implements $FlightPlanListCopyWith<$Res> {
  factory _$$FlightPlanListImplCopyWith(_$FlightPlanListImpl value,
          $Res Function(_$FlightPlanListImpl) then) =
      __$$FlightPlanListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FlightPlan> flightPlanList});
}

/// @nodoc
class __$$FlightPlanListImplCopyWithImpl<$Res>
    extends _$FlightPlanListCopyWithImpl<$Res, _$FlightPlanListImpl>
    implements _$$FlightPlanListImplCopyWith<$Res> {
  __$$FlightPlanListImplCopyWithImpl(
      _$FlightPlanListImpl _value, $Res Function(_$FlightPlanListImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlightPlanList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flightPlanList = null,
  }) {
    return _then(_$FlightPlanListImpl(
      flightPlanList: null == flightPlanList
          ? _value._flightPlanList
          : flightPlanList // ignore: cast_nullable_to_non_nullable
              as List<FlightPlan>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FlightPlanListImpl implements _FlightPlanList {
  const _$FlightPlanListImpl({required final List<FlightPlan> flightPlanList})
      : _flightPlanList = flightPlanList;

  factory _$FlightPlanListImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlightPlanListImplFromJson(json);

  final List<FlightPlan> _flightPlanList;
  @override
  List<FlightPlan> get flightPlanList {
    if (_flightPlanList is EqualUnmodifiableListView) return _flightPlanList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flightPlanList);
  }

  @override
  String toString() {
    return 'FlightPlanList(flightPlanList: $flightPlanList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlightPlanListImpl &&
            const DeepCollectionEquality()
                .equals(other._flightPlanList, _flightPlanList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_flightPlanList));

  /// Create a copy of FlightPlanList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlightPlanListImplCopyWith<_$FlightPlanListImpl> get copyWith =>
      __$$FlightPlanListImplCopyWithImpl<_$FlightPlanListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlightPlanListImplToJson(
      this,
    );
  }
}

abstract class _FlightPlanList implements FlightPlanList {
  const factory _FlightPlanList(
      {required final List<FlightPlan> flightPlanList}) = _$FlightPlanListImpl;

  factory _FlightPlanList.fromJson(Map<String, dynamic> json) =
      _$FlightPlanListImpl.fromJson;

  @override
  List<FlightPlan> get flightPlanList;

  /// Create a copy of FlightPlanList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlightPlanListImplCopyWith<_$FlightPlanListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
