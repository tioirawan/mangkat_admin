// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fleet_position_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FleetPositionModel _$FleetPositionModelFromJson(Map<String, dynamic> json) {
  return _FleetPositionModel.fromJson(json);
}

/// @nodoc
mixin _$FleetPositionModel {
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get heading => throw _privateConstructorUsedError;
  double? get speed => throw _privateConstructorUsedError;
  double? get odometer => throw _privateConstructorUsedError;
  @JsonKey(toJson: _encodeTimestamp, fromJson: _decodeTimestamp)
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FleetPositionModelCopyWith<FleetPositionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FleetPositionModelCopyWith<$Res> {
  factory $FleetPositionModelCopyWith(
          FleetPositionModel value, $Res Function(FleetPositionModel) then) =
      _$FleetPositionModelCopyWithImpl<$Res, FleetPositionModel>;
  @useResult
  $Res call(
      {double? latitude,
      double? longitude,
      double? heading,
      double? speed,
      double? odometer,
      @JsonKey(toJson: _encodeTimestamp, fromJson: _decodeTimestamp)
      DateTime? timestamp});
}

/// @nodoc
class _$FleetPositionModelCopyWithImpl<$Res, $Val extends FleetPositionModel>
    implements $FleetPositionModelCopyWith<$Res> {
  _$FleetPositionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? heading = freezed,
    Object? speed = freezed,
    Object? odometer = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      heading: freezed == heading
          ? _value.heading
          : heading // ignore: cast_nullable_to_non_nullable
              as double?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double?,
      odometer: freezed == odometer
          ? _value.odometer
          : odometer // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FleetPositionModelImplCopyWith<$Res>
    implements $FleetPositionModelCopyWith<$Res> {
  factory _$$FleetPositionModelImplCopyWith(_$FleetPositionModelImpl value,
          $Res Function(_$FleetPositionModelImpl) then) =
      __$$FleetPositionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? latitude,
      double? longitude,
      double? heading,
      double? speed,
      double? odometer,
      @JsonKey(toJson: _encodeTimestamp, fromJson: _decodeTimestamp)
      DateTime? timestamp});
}

/// @nodoc
class __$$FleetPositionModelImplCopyWithImpl<$Res>
    extends _$FleetPositionModelCopyWithImpl<$Res, _$FleetPositionModelImpl>
    implements _$$FleetPositionModelImplCopyWith<$Res> {
  __$$FleetPositionModelImplCopyWithImpl(_$FleetPositionModelImpl _value,
      $Res Function(_$FleetPositionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? heading = freezed,
    Object? speed = freezed,
    Object? odometer = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$FleetPositionModelImpl(
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      heading: freezed == heading
          ? _value.heading
          : heading // ignore: cast_nullable_to_non_nullable
              as double?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double?,
      odometer: freezed == odometer
          ? _value.odometer
          : odometer // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FleetPositionModelImpl extends _FleetPositionModel {
  _$FleetPositionModelImpl(
      {this.latitude,
      this.longitude,
      this.heading,
      this.speed,
      this.odometer,
      @JsonKey(toJson: _encodeTimestamp, fromJson: _decodeTimestamp)
      this.timestamp})
      : super._();

  factory _$FleetPositionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FleetPositionModelImplFromJson(json);

  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? heading;
  @override
  final double? speed;
  @override
  final double? odometer;
  @override
  @JsonKey(toJson: _encodeTimestamp, fromJson: _decodeTimestamp)
  final DateTime? timestamp;

  @override
  String toString() {
    return 'FleetPositionModel(latitude: $latitude, longitude: $longitude, heading: $heading, speed: $speed, odometer: $odometer, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FleetPositionModelImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.heading, heading) || other.heading == heading) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.odometer, odometer) ||
                other.odometer == odometer) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, latitude, longitude, heading, speed, odometer, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FleetPositionModelImplCopyWith<_$FleetPositionModelImpl> get copyWith =>
      __$$FleetPositionModelImplCopyWithImpl<_$FleetPositionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FleetPositionModelImplToJson(
      this,
    );
  }
}

abstract class _FleetPositionModel extends FleetPositionModel {
  factory _FleetPositionModel(
      {final double? latitude,
      final double? longitude,
      final double? heading,
      final double? speed,
      final double? odometer,
      @JsonKey(toJson: _encodeTimestamp, fromJson: _decodeTimestamp)
      final DateTime? timestamp}) = _$FleetPositionModelImpl;
  _FleetPositionModel._() : super._();

  factory _FleetPositionModel.fromJson(Map<String, dynamic> json) =
      _$FleetPositionModelImpl.fromJson;

  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double? get heading;
  @override
  double? get speed;
  @override
  double? get odometer;
  @override
  @JsonKey(toJson: _encodeTimestamp, fromJson: _decodeTimestamp)
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$FleetPositionModelImplCopyWith<_$FleetPositionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
