// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'load_balancer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoadBalancerState {
  Map<RouteModel, RouteDetail> get routesDetails =>
      throw _privateConstructorUsedError;
  int get maxIteration => throw _privateConstructorUsedError;
  double get convergenceThreshold => throw _privateConstructorUsedError;
  double get adjustmentFactor => throw _privateConstructorUsedError;
  RouteModel? get routeWithMaxLoad => throw _privateConstructorUsedError;
  RouteModel? get routeWithMinLoad => throw _privateConstructorUsedError;
  double get imbalance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoadBalancerStateCopyWith<LoadBalancerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadBalancerStateCopyWith<$Res> {
  factory $LoadBalancerStateCopyWith(
          LoadBalancerState value, $Res Function(LoadBalancerState) then) =
      _$LoadBalancerStateCopyWithImpl<$Res, LoadBalancerState>;
  @useResult
  $Res call(
      {Map<RouteModel, RouteDetail> routesDetails,
      int maxIteration,
      double convergenceThreshold,
      double adjustmentFactor,
      RouteModel? routeWithMaxLoad,
      RouteModel? routeWithMinLoad,
      double imbalance});

  $RouteModelCopyWith<$Res>? get routeWithMaxLoad;
  $RouteModelCopyWith<$Res>? get routeWithMinLoad;
}

/// @nodoc
class _$LoadBalancerStateCopyWithImpl<$Res, $Val extends LoadBalancerState>
    implements $LoadBalancerStateCopyWith<$Res> {
  _$LoadBalancerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routesDetails = null,
    Object? maxIteration = null,
    Object? convergenceThreshold = null,
    Object? adjustmentFactor = null,
    Object? routeWithMaxLoad = freezed,
    Object? routeWithMinLoad = freezed,
    Object? imbalance = null,
  }) {
    return _then(_value.copyWith(
      routesDetails: null == routesDetails
          ? _value.routesDetails
          : routesDetails // ignore: cast_nullable_to_non_nullable
              as Map<RouteModel, RouteDetail>,
      maxIteration: null == maxIteration
          ? _value.maxIteration
          : maxIteration // ignore: cast_nullable_to_non_nullable
              as int,
      convergenceThreshold: null == convergenceThreshold
          ? _value.convergenceThreshold
          : convergenceThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      adjustmentFactor: null == adjustmentFactor
          ? _value.adjustmentFactor
          : adjustmentFactor // ignore: cast_nullable_to_non_nullable
              as double,
      routeWithMaxLoad: freezed == routeWithMaxLoad
          ? _value.routeWithMaxLoad
          : routeWithMaxLoad // ignore: cast_nullable_to_non_nullable
              as RouteModel?,
      routeWithMinLoad: freezed == routeWithMinLoad
          ? _value.routeWithMinLoad
          : routeWithMinLoad // ignore: cast_nullable_to_non_nullable
              as RouteModel?,
      imbalance: null == imbalance
          ? _value.imbalance
          : imbalance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RouteModelCopyWith<$Res>? get routeWithMaxLoad {
    if (_value.routeWithMaxLoad == null) {
      return null;
    }

    return $RouteModelCopyWith<$Res>(_value.routeWithMaxLoad!, (value) {
      return _then(_value.copyWith(routeWithMaxLoad: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RouteModelCopyWith<$Res>? get routeWithMinLoad {
    if (_value.routeWithMinLoad == null) {
      return null;
    }

    return $RouteModelCopyWith<$Res>(_value.routeWithMinLoad!, (value) {
      return _then(_value.copyWith(routeWithMinLoad: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadBalancerStateImplCopyWith<$Res>
    implements $LoadBalancerStateCopyWith<$Res> {
  factory _$$LoadBalancerStateImplCopyWith(_$LoadBalancerStateImpl value,
          $Res Function(_$LoadBalancerStateImpl) then) =
      __$$LoadBalancerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<RouteModel, RouteDetail> routesDetails,
      int maxIteration,
      double convergenceThreshold,
      double adjustmentFactor,
      RouteModel? routeWithMaxLoad,
      RouteModel? routeWithMinLoad,
      double imbalance});

  @override
  $RouteModelCopyWith<$Res>? get routeWithMaxLoad;
  @override
  $RouteModelCopyWith<$Res>? get routeWithMinLoad;
}

/// @nodoc
class __$$LoadBalancerStateImplCopyWithImpl<$Res>
    extends _$LoadBalancerStateCopyWithImpl<$Res, _$LoadBalancerStateImpl>
    implements _$$LoadBalancerStateImplCopyWith<$Res> {
  __$$LoadBalancerStateImplCopyWithImpl(_$LoadBalancerStateImpl _value,
      $Res Function(_$LoadBalancerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routesDetails = null,
    Object? maxIteration = null,
    Object? convergenceThreshold = null,
    Object? adjustmentFactor = null,
    Object? routeWithMaxLoad = freezed,
    Object? routeWithMinLoad = freezed,
    Object? imbalance = null,
  }) {
    return _then(_$LoadBalancerStateImpl(
      routesDetails: null == routesDetails
          ? _value._routesDetails
          : routesDetails // ignore: cast_nullable_to_non_nullable
              as Map<RouteModel, RouteDetail>,
      maxIteration: null == maxIteration
          ? _value.maxIteration
          : maxIteration // ignore: cast_nullable_to_non_nullable
              as int,
      convergenceThreshold: null == convergenceThreshold
          ? _value.convergenceThreshold
          : convergenceThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      adjustmentFactor: null == adjustmentFactor
          ? _value.adjustmentFactor
          : adjustmentFactor // ignore: cast_nullable_to_non_nullable
              as double,
      routeWithMaxLoad: freezed == routeWithMaxLoad
          ? _value.routeWithMaxLoad
          : routeWithMaxLoad // ignore: cast_nullable_to_non_nullable
              as RouteModel?,
      routeWithMinLoad: freezed == routeWithMinLoad
          ? _value.routeWithMinLoad
          : routeWithMinLoad // ignore: cast_nullable_to_non_nullable
              as RouteModel?,
      imbalance: null == imbalance
          ? _value.imbalance
          : imbalance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$LoadBalancerStateImpl implements _LoadBalancerState {
  _$LoadBalancerStateImpl(
      {required final Map<RouteModel, RouteDetail> routesDetails,
      this.maxIteration = 10,
      this.convergenceThreshold = 0.5,
      this.adjustmentFactor = 0.1,
      this.routeWithMaxLoad,
      this.routeWithMinLoad,
      this.imbalance = 0})
      : _routesDetails = routesDetails;

  final Map<RouteModel, RouteDetail> _routesDetails;
  @override
  Map<RouteModel, RouteDetail> get routesDetails {
    if (_routesDetails is EqualUnmodifiableMapView) return _routesDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_routesDetails);
  }

  @override
  @JsonKey()
  final int maxIteration;
  @override
  @JsonKey()
  final double convergenceThreshold;
  @override
  @JsonKey()
  final double adjustmentFactor;
  @override
  final RouteModel? routeWithMaxLoad;
  @override
  final RouteModel? routeWithMinLoad;
  @override
  @JsonKey()
  final double imbalance;

  @override
  String toString() {
    return 'LoadBalancerState(routesDetails: $routesDetails, maxIteration: $maxIteration, convergenceThreshold: $convergenceThreshold, adjustmentFactor: $adjustmentFactor, routeWithMaxLoad: $routeWithMaxLoad, routeWithMinLoad: $routeWithMinLoad, imbalance: $imbalance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadBalancerStateImpl &&
            const DeepCollectionEquality()
                .equals(other._routesDetails, _routesDetails) &&
            (identical(other.maxIteration, maxIteration) ||
                other.maxIteration == maxIteration) &&
            (identical(other.convergenceThreshold, convergenceThreshold) ||
                other.convergenceThreshold == convergenceThreshold) &&
            (identical(other.adjustmentFactor, adjustmentFactor) ||
                other.adjustmentFactor == adjustmentFactor) &&
            (identical(other.routeWithMaxLoad, routeWithMaxLoad) ||
                other.routeWithMaxLoad == routeWithMaxLoad) &&
            (identical(other.routeWithMinLoad, routeWithMinLoad) ||
                other.routeWithMinLoad == routeWithMinLoad) &&
            (identical(other.imbalance, imbalance) ||
                other.imbalance == imbalance));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_routesDetails),
      maxIteration,
      convergenceThreshold,
      adjustmentFactor,
      routeWithMaxLoad,
      routeWithMinLoad,
      imbalance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadBalancerStateImplCopyWith<_$LoadBalancerStateImpl> get copyWith =>
      __$$LoadBalancerStateImplCopyWithImpl<_$LoadBalancerStateImpl>(
          this, _$identity);
}

abstract class _LoadBalancerState implements LoadBalancerState {
  factory _LoadBalancerState(
      {required final Map<RouteModel, RouteDetail> routesDetails,
      final int maxIteration,
      final double convergenceThreshold,
      final double adjustmentFactor,
      final RouteModel? routeWithMaxLoad,
      final RouteModel? routeWithMinLoad,
      final double imbalance}) = _$LoadBalancerStateImpl;

  @override
  Map<RouteModel, RouteDetail> get routesDetails;
  @override
  int get maxIteration;
  @override
  double get convergenceThreshold;
  @override
  double get adjustmentFactor;
  @override
  RouteModel? get routeWithMaxLoad;
  @override
  RouteModel? get routeWithMinLoad;
  @override
  double get imbalance;
  @override
  @JsonKey(ignore: true)
  _$$LoadBalancerStateImplCopyWith<_$LoadBalancerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
