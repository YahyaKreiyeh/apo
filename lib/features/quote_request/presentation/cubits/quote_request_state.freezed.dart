// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuoteRequestState {

 Result<void> get status; String get firstName; String get lastName; String get email; String get phone; String get companyName; String get shipLine1; String get shipLine2; String get shipCity; String get shipState; String get shipZip; String get shipCountry; String get billLine1; String get billLine2; String get billCity; String get billState; String get billZip; String get billCountry; String get customerNotes; String get artworkDescription; String get numberOfLocations; DateTime? get desiredShipDate;
/// Create a copy of QuoteRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteRequestStateCopyWith<QuoteRequestState> get copyWith => _$QuoteRequestStateCopyWithImpl<QuoteRequestState>(this as QuoteRequestState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteRequestState&&(identical(other.status, status) || other.status == status)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.shipLine1, shipLine1) || other.shipLine1 == shipLine1)&&(identical(other.shipLine2, shipLine2) || other.shipLine2 == shipLine2)&&(identical(other.shipCity, shipCity) || other.shipCity == shipCity)&&(identical(other.shipState, shipState) || other.shipState == shipState)&&(identical(other.shipZip, shipZip) || other.shipZip == shipZip)&&(identical(other.shipCountry, shipCountry) || other.shipCountry == shipCountry)&&(identical(other.billLine1, billLine1) || other.billLine1 == billLine1)&&(identical(other.billLine2, billLine2) || other.billLine2 == billLine2)&&(identical(other.billCity, billCity) || other.billCity == billCity)&&(identical(other.billState, billState) || other.billState == billState)&&(identical(other.billZip, billZip) || other.billZip == billZip)&&(identical(other.billCountry, billCountry) || other.billCountry == billCountry)&&(identical(other.customerNotes, customerNotes) || other.customerNotes == customerNotes)&&(identical(other.artworkDescription, artworkDescription) || other.artworkDescription == artworkDescription)&&(identical(other.numberOfLocations, numberOfLocations) || other.numberOfLocations == numberOfLocations)&&(identical(other.desiredShipDate, desiredShipDate) || other.desiredShipDate == desiredShipDate));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,firstName,lastName,email,phone,companyName,shipLine1,shipLine2,shipCity,shipState,shipZip,shipCountry,billLine1,billLine2,billCity,billState,billZip,billCountry,customerNotes,artworkDescription,numberOfLocations,desiredShipDate]);

@override
String toString() {
  return 'QuoteRequestState(status: $status, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, companyName: $companyName, shipLine1: $shipLine1, shipLine2: $shipLine2, shipCity: $shipCity, shipState: $shipState, shipZip: $shipZip, shipCountry: $shipCountry, billLine1: $billLine1, billLine2: $billLine2, billCity: $billCity, billState: $billState, billZip: $billZip, billCountry: $billCountry, customerNotes: $customerNotes, artworkDescription: $artworkDescription, numberOfLocations: $numberOfLocations, desiredShipDate: $desiredShipDate)';
}


}

/// @nodoc
abstract mixin class $QuoteRequestStateCopyWith<$Res>  {
  factory $QuoteRequestStateCopyWith(QuoteRequestState value, $Res Function(QuoteRequestState) _then) = _$QuoteRequestStateCopyWithImpl;
@useResult
$Res call({
 Result<void> status, String firstName, String lastName, String email, String phone, String companyName, String shipLine1, String shipLine2, String shipCity, String shipState, String shipZip, String shipCountry, String billLine1, String billLine2, String billCity, String billState, String billZip, String billCountry, String customerNotes, String artworkDescription, String numberOfLocations, DateTime? desiredShipDate
});


$ResultCopyWith<void, $Res> get status;

}
/// @nodoc
class _$QuoteRequestStateCopyWithImpl<$Res>
    implements $QuoteRequestStateCopyWith<$Res> {
  _$QuoteRequestStateCopyWithImpl(this._self, this._then);

  final QuoteRequestState _self;
  final $Res Function(QuoteRequestState) _then;

/// Create a copy of QuoteRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? companyName = null,Object? shipLine1 = null,Object? shipLine2 = null,Object? shipCity = null,Object? shipState = null,Object? shipZip = null,Object? shipCountry = null,Object? billLine1 = null,Object? billLine2 = null,Object? billCity = null,Object? billState = null,Object? billZip = null,Object? billCountry = null,Object? customerNotes = null,Object? artworkDescription = null,Object? numberOfLocations = null,Object? desiredShipDate = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Result<void>,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,shipLine1: null == shipLine1 ? _self.shipLine1 : shipLine1 // ignore: cast_nullable_to_non_nullable
as String,shipLine2: null == shipLine2 ? _self.shipLine2 : shipLine2 // ignore: cast_nullable_to_non_nullable
as String,shipCity: null == shipCity ? _self.shipCity : shipCity // ignore: cast_nullable_to_non_nullable
as String,shipState: null == shipState ? _self.shipState : shipState // ignore: cast_nullable_to_non_nullable
as String,shipZip: null == shipZip ? _self.shipZip : shipZip // ignore: cast_nullable_to_non_nullable
as String,shipCountry: null == shipCountry ? _self.shipCountry : shipCountry // ignore: cast_nullable_to_non_nullable
as String,billLine1: null == billLine1 ? _self.billLine1 : billLine1 // ignore: cast_nullable_to_non_nullable
as String,billLine2: null == billLine2 ? _self.billLine2 : billLine2 // ignore: cast_nullable_to_non_nullable
as String,billCity: null == billCity ? _self.billCity : billCity // ignore: cast_nullable_to_non_nullable
as String,billState: null == billState ? _self.billState : billState // ignore: cast_nullable_to_non_nullable
as String,billZip: null == billZip ? _self.billZip : billZip // ignore: cast_nullable_to_non_nullable
as String,billCountry: null == billCountry ? _self.billCountry : billCountry // ignore: cast_nullable_to_non_nullable
as String,customerNotes: null == customerNotes ? _self.customerNotes : customerNotes // ignore: cast_nullable_to_non_nullable
as String,artworkDescription: null == artworkDescription ? _self.artworkDescription : artworkDescription // ignore: cast_nullable_to_non_nullable
as String,numberOfLocations: null == numberOfLocations ? _self.numberOfLocations : numberOfLocations // ignore: cast_nullable_to_non_nullable
as String,desiredShipDate: freezed == desiredShipDate ? _self.desiredShipDate : desiredShipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of QuoteRequestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<void, $Res> get status {
  
  return $ResultCopyWith<void, $Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuoteRequestState].
extension QuoteRequestStatePatterns on QuoteRequestState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteRequestState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteRequestState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteRequestState value)  $default,){
final _that = this;
switch (_that) {
case _QuoteRequestState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteRequestState value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteRequestState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Result<void> status,  String firstName,  String lastName,  String email,  String phone,  String companyName,  String shipLine1,  String shipLine2,  String shipCity,  String shipState,  String shipZip,  String shipCountry,  String billLine1,  String billLine2,  String billCity,  String billState,  String billZip,  String billCountry,  String customerNotes,  String artworkDescription,  String numberOfLocations,  DateTime? desiredShipDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteRequestState() when $default != null:
return $default(_that.status,_that.firstName,_that.lastName,_that.email,_that.phone,_that.companyName,_that.shipLine1,_that.shipLine2,_that.shipCity,_that.shipState,_that.shipZip,_that.shipCountry,_that.billLine1,_that.billLine2,_that.billCity,_that.billState,_that.billZip,_that.billCountry,_that.customerNotes,_that.artworkDescription,_that.numberOfLocations,_that.desiredShipDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Result<void> status,  String firstName,  String lastName,  String email,  String phone,  String companyName,  String shipLine1,  String shipLine2,  String shipCity,  String shipState,  String shipZip,  String shipCountry,  String billLine1,  String billLine2,  String billCity,  String billState,  String billZip,  String billCountry,  String customerNotes,  String artworkDescription,  String numberOfLocations,  DateTime? desiredShipDate)  $default,) {final _that = this;
switch (_that) {
case _QuoteRequestState():
return $default(_that.status,_that.firstName,_that.lastName,_that.email,_that.phone,_that.companyName,_that.shipLine1,_that.shipLine2,_that.shipCity,_that.shipState,_that.shipZip,_that.shipCountry,_that.billLine1,_that.billLine2,_that.billCity,_that.billState,_that.billZip,_that.billCountry,_that.customerNotes,_that.artworkDescription,_that.numberOfLocations,_that.desiredShipDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Result<void> status,  String firstName,  String lastName,  String email,  String phone,  String companyName,  String shipLine1,  String shipLine2,  String shipCity,  String shipState,  String shipZip,  String shipCountry,  String billLine1,  String billLine2,  String billCity,  String billState,  String billZip,  String billCountry,  String customerNotes,  String artworkDescription,  String numberOfLocations,  DateTime? desiredShipDate)?  $default,) {final _that = this;
switch (_that) {
case _QuoteRequestState() when $default != null:
return $default(_that.status,_that.firstName,_that.lastName,_that.email,_that.phone,_that.companyName,_that.shipLine1,_that.shipLine2,_that.shipCity,_that.shipState,_that.shipZip,_that.shipCountry,_that.billLine1,_that.billLine2,_that.billCity,_that.billState,_that.billZip,_that.billCountry,_that.customerNotes,_that.artworkDescription,_that.numberOfLocations,_that.desiredShipDate);case _:
  return null;

}
}

}

/// @nodoc


class _QuoteRequestState implements QuoteRequestState {
  const _QuoteRequestState({this.status = const Result.empty(), this.firstName = '', this.lastName = '', this.email = '', this.phone = '', this.companyName = '', this.shipLine1 = '', this.shipLine2 = '', this.shipCity = '', this.shipState = '', this.shipZip = '', this.shipCountry = '', this.billLine1 = '', this.billLine2 = '', this.billCity = '', this.billState = '', this.billZip = '', this.billCountry = '', this.customerNotes = '', this.artworkDescription = '', this.numberOfLocations = '1', this.desiredShipDate = null});
  

@override@JsonKey() final  Result<void> status;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String companyName;
@override@JsonKey() final  String shipLine1;
@override@JsonKey() final  String shipLine2;
@override@JsonKey() final  String shipCity;
@override@JsonKey() final  String shipState;
@override@JsonKey() final  String shipZip;
@override@JsonKey() final  String shipCountry;
@override@JsonKey() final  String billLine1;
@override@JsonKey() final  String billLine2;
@override@JsonKey() final  String billCity;
@override@JsonKey() final  String billState;
@override@JsonKey() final  String billZip;
@override@JsonKey() final  String billCountry;
@override@JsonKey() final  String customerNotes;
@override@JsonKey() final  String artworkDescription;
@override@JsonKey() final  String numberOfLocations;
@override@JsonKey() final  DateTime? desiredShipDate;

/// Create a copy of QuoteRequestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteRequestStateCopyWith<_QuoteRequestState> get copyWith => __$QuoteRequestStateCopyWithImpl<_QuoteRequestState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteRequestState&&(identical(other.status, status) || other.status == status)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.shipLine1, shipLine1) || other.shipLine1 == shipLine1)&&(identical(other.shipLine2, shipLine2) || other.shipLine2 == shipLine2)&&(identical(other.shipCity, shipCity) || other.shipCity == shipCity)&&(identical(other.shipState, shipState) || other.shipState == shipState)&&(identical(other.shipZip, shipZip) || other.shipZip == shipZip)&&(identical(other.shipCountry, shipCountry) || other.shipCountry == shipCountry)&&(identical(other.billLine1, billLine1) || other.billLine1 == billLine1)&&(identical(other.billLine2, billLine2) || other.billLine2 == billLine2)&&(identical(other.billCity, billCity) || other.billCity == billCity)&&(identical(other.billState, billState) || other.billState == billState)&&(identical(other.billZip, billZip) || other.billZip == billZip)&&(identical(other.billCountry, billCountry) || other.billCountry == billCountry)&&(identical(other.customerNotes, customerNotes) || other.customerNotes == customerNotes)&&(identical(other.artworkDescription, artworkDescription) || other.artworkDescription == artworkDescription)&&(identical(other.numberOfLocations, numberOfLocations) || other.numberOfLocations == numberOfLocations)&&(identical(other.desiredShipDate, desiredShipDate) || other.desiredShipDate == desiredShipDate));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,firstName,lastName,email,phone,companyName,shipLine1,shipLine2,shipCity,shipState,shipZip,shipCountry,billLine1,billLine2,billCity,billState,billZip,billCountry,customerNotes,artworkDescription,numberOfLocations,desiredShipDate]);

@override
String toString() {
  return 'QuoteRequestState(status: $status, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, companyName: $companyName, shipLine1: $shipLine1, shipLine2: $shipLine2, shipCity: $shipCity, shipState: $shipState, shipZip: $shipZip, shipCountry: $shipCountry, billLine1: $billLine1, billLine2: $billLine2, billCity: $billCity, billState: $billState, billZip: $billZip, billCountry: $billCountry, customerNotes: $customerNotes, artworkDescription: $artworkDescription, numberOfLocations: $numberOfLocations, desiredShipDate: $desiredShipDate)';
}


}

/// @nodoc
abstract mixin class _$QuoteRequestStateCopyWith<$Res> implements $QuoteRequestStateCopyWith<$Res> {
  factory _$QuoteRequestStateCopyWith(_QuoteRequestState value, $Res Function(_QuoteRequestState) _then) = __$QuoteRequestStateCopyWithImpl;
@override @useResult
$Res call({
 Result<void> status, String firstName, String lastName, String email, String phone, String companyName, String shipLine1, String shipLine2, String shipCity, String shipState, String shipZip, String shipCountry, String billLine1, String billLine2, String billCity, String billState, String billZip, String billCountry, String customerNotes, String artworkDescription, String numberOfLocations, DateTime? desiredShipDate
});


@override $ResultCopyWith<void, $Res> get status;

}
/// @nodoc
class __$QuoteRequestStateCopyWithImpl<$Res>
    implements _$QuoteRequestStateCopyWith<$Res> {
  __$QuoteRequestStateCopyWithImpl(this._self, this._then);

  final _QuoteRequestState _self;
  final $Res Function(_QuoteRequestState) _then;

/// Create a copy of QuoteRequestState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? companyName = null,Object? shipLine1 = null,Object? shipLine2 = null,Object? shipCity = null,Object? shipState = null,Object? shipZip = null,Object? shipCountry = null,Object? billLine1 = null,Object? billLine2 = null,Object? billCity = null,Object? billState = null,Object? billZip = null,Object? billCountry = null,Object? customerNotes = null,Object? artworkDescription = null,Object? numberOfLocations = null,Object? desiredShipDate = freezed,}) {
  return _then(_QuoteRequestState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Result<void>,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,shipLine1: null == shipLine1 ? _self.shipLine1 : shipLine1 // ignore: cast_nullable_to_non_nullable
as String,shipLine2: null == shipLine2 ? _self.shipLine2 : shipLine2 // ignore: cast_nullable_to_non_nullable
as String,shipCity: null == shipCity ? _self.shipCity : shipCity // ignore: cast_nullable_to_non_nullable
as String,shipState: null == shipState ? _self.shipState : shipState // ignore: cast_nullable_to_non_nullable
as String,shipZip: null == shipZip ? _self.shipZip : shipZip // ignore: cast_nullable_to_non_nullable
as String,shipCountry: null == shipCountry ? _self.shipCountry : shipCountry // ignore: cast_nullable_to_non_nullable
as String,billLine1: null == billLine1 ? _self.billLine1 : billLine1 // ignore: cast_nullable_to_non_nullable
as String,billLine2: null == billLine2 ? _self.billLine2 : billLine2 // ignore: cast_nullable_to_non_nullable
as String,billCity: null == billCity ? _self.billCity : billCity // ignore: cast_nullable_to_non_nullable
as String,billState: null == billState ? _self.billState : billState // ignore: cast_nullable_to_non_nullable
as String,billZip: null == billZip ? _self.billZip : billZip // ignore: cast_nullable_to_non_nullable
as String,billCountry: null == billCountry ? _self.billCountry : billCountry // ignore: cast_nullable_to_non_nullable
as String,customerNotes: null == customerNotes ? _self.customerNotes : customerNotes // ignore: cast_nullable_to_non_nullable
as String,artworkDescription: null == artworkDescription ? _self.artworkDescription : artworkDescription // ignore: cast_nullable_to_non_nullable
as String,numberOfLocations: null == numberOfLocations ? _self.numberOfLocations : numberOfLocations // ignore: cast_nullable_to_non_nullable
as String,desiredShipDate: freezed == desiredShipDate ? _self.desiredShipDate : desiredShipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of QuoteRequestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<void, $Res> get status {
  
  return $ResultCopyWith<void, $Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
