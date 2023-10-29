// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) {
  return _DriverModel.fromJson(json);
}

/// @nodoc
mixin _$DriverModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'driving_license_number')
  String? get drivingLicenseNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'driving_license_expiry_date')
  DateTime? get drivingLicenseExpiryDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DriverModelCopyWith<DriverModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverModelCopyWith<$Res> {
  factory $DriverModelCopyWith(
          DriverModel value, $Res Function(DriverModel) then) =
      _$DriverModelCopyWithImpl<$Res, DriverModel>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? phone,
      String? email,
      String? address,
      String? image,
      @JsonKey(name: 'driving_license_number') String? drivingLicenseNumber,
      @JsonKey(name: 'driving_license_expiry_date')
      DateTime? drivingLicenseExpiryDate,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class _$DriverModelCopyWithImpl<$Res, $Val extends DriverModel>
    implements $DriverModelCopyWith<$Res> {
  _$DriverModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? image = freezed,
    Object? drivingLicenseNumber = freezed,
    Object? drivingLicenseExpiryDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? reference = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      drivingLicenseNumber: freezed == drivingLicenseNumber
          ? _value.drivingLicenseNumber
          : drivingLicenseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      drivingLicenseExpiryDate: freezed == drivingLicenseExpiryDate
          ? _value.drivingLicenseExpiryDate
          : drivingLicenseExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverModelImplCopyWith<$Res>
    implements $DriverModelCopyWith<$Res> {
  factory _$$DriverModelImplCopyWith(
          _$DriverModelImpl value, $Res Function(_$DriverModelImpl) then) =
      __$$DriverModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? phone,
      String? email,
      String? address,
      String? image,
      @JsonKey(name: 'driving_license_number') String? drivingLicenseNumber,
      @JsonKey(name: 'driving_license_expiry_date')
      DateTime? drivingLicenseExpiryDate,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DocumentReference<Object?>? reference});
}

/// @nodoc
class __$$DriverModelImplCopyWithImpl<$Res>
    extends _$DriverModelCopyWithImpl<$Res, _$DriverModelImpl>
    implements _$$DriverModelImplCopyWith<$Res> {
  __$$DriverModelImplCopyWithImpl(
      _$DriverModelImpl _value, $Res Function(_$DriverModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? image = freezed,
    Object? drivingLicenseNumber = freezed,
    Object? drivingLicenseExpiryDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$DriverModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      drivingLicenseNumber: freezed == drivingLicenseNumber
          ? _value.drivingLicenseNumber
          : drivingLicenseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      drivingLicenseExpiryDate: freezed == drivingLicenseExpiryDate
          ? _value.drivingLicenseExpiryDate
          : drivingLicenseExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverModelImpl extends _DriverModel {
  _$DriverModelImpl(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.image,
      @JsonKey(name: 'driving_license_number') this.drivingLicenseNumber,
      @JsonKey(name: 'driving_license_expiry_date')
      this.drivingLicenseExpiryDate,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: false) this.reference})
      : super._();

  factory _$DriverModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? address;
  @override
  final String? image;
  @override
  @JsonKey(name: 'driving_license_number')
  final String? drivingLicenseNumber;
  @override
  @JsonKey(name: 'driving_license_expiry_date')
  final DateTime? drivingLicenseExpiryDate;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final DocumentReference<Object?>? reference;

  @override
  String toString() {
    return 'DriverModel(id: $id, name: $name, phone: $phone, email: $email, address: $address, image: $image, drivingLicenseNumber: $drivingLicenseNumber, drivingLicenseExpiryDate: $drivingLicenseExpiryDate, createdAt: $createdAt, updatedAt: $updatedAt, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.drivingLicenseNumber, drivingLicenseNumber) ||
                other.drivingLicenseNumber == drivingLicenseNumber) &&
            (identical(
                    other.drivingLicenseExpiryDate, drivingLicenseExpiryDate) ||
                other.drivingLicenseExpiryDate == drivingLicenseExpiryDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      phone,
      email,
      address,
      image,
      drivingLicenseNumber,
      drivingLicenseExpiryDate,
      createdAt,
      updatedAt,
      reference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverModelImplCopyWith<_$DriverModelImpl> get copyWith =>
      __$$DriverModelImplCopyWithImpl<_$DriverModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverModelImplToJson(
      this,
    );
  }
}

abstract class _DriverModel extends DriverModel {
  factory _DriverModel(
      {final String? id,
      final String? name,
      final String? phone,
      final String? email,
      final String? address,
      final String? image,
      @JsonKey(name: 'driving_license_number')
      final String? drivingLicenseNumber,
      @JsonKey(name: 'driving_license_expiry_date')
      final DateTime? drivingLicenseExpiryDate,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final DocumentReference<Object?>? reference}) = _$DriverModelImpl;
  _DriverModel._() : super._();

  factory _DriverModel.fromJson(Map<String, dynamic> json) =
      _$DriverModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get address;
  @override
  String? get image;
  @override
  @JsonKey(name: 'driving_license_number')
  String? get drivingLicenseNumber;
  @override
  @JsonKey(name: 'driving_license_expiry_date')
  DateTime? get drivingLicenseExpiryDate;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference<Object?>? get reference;
  @override
  @JsonKey(ignore: true)
  _$$DriverModelImplCopyWith<_$DriverModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
