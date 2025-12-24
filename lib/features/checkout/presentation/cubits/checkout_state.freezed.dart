// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutState {

 Result<void> get status; CheckoutType get type; Result<List<ShipViaOptionEntity>> get shipViaStatus; List<ShipViaOptionEntity> get shipViaOptions; String? get selectedShipViaCode; Result<List<ShipViaOptionEntity>> get transferTypeStatus; List<ShipViaOptionEntity> get transferTypeOptions; Result<List<ShipViaOptionEntity>> get sheetTypeStatus; List<ShipViaOptionEntity> get sheetTypeOptions; Result<List<TransferEntity>> get transfersStatus; List<TransferEntity> get transferOptions; List<int> get selectedTransferIds; String get jobDescription; String get jobComment; String get shippingInstructions; DateTime? get requestedShipDate; bool get mustShipByRequestedDate; String get firstName; String get lastName; String get email; String get phone; String get companyName; String get shipLine1; String get shipLine2; String get shipCity; String get shipState; String get shipZip; String get billLine1; String get billLine2; String get billCity; String get billState; String get billZip; String get customerNotes; String get artworkDescription; String get numberOfLocations; DateTime? get desiredShipDate;
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutStateCopyWith<CheckoutState> get copyWith => _$CheckoutStateCopyWithImpl<CheckoutState>(this as CheckoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.shipViaStatus, shipViaStatus) || other.shipViaStatus == shipViaStatus)&&const DeepCollectionEquality().equals(other.shipViaOptions, shipViaOptions)&&(identical(other.selectedShipViaCode, selectedShipViaCode) || other.selectedShipViaCode == selectedShipViaCode)&&(identical(other.transferTypeStatus, transferTypeStatus) || other.transferTypeStatus == transferTypeStatus)&&const DeepCollectionEquality().equals(other.transferTypeOptions, transferTypeOptions)&&(identical(other.sheetTypeStatus, sheetTypeStatus) || other.sheetTypeStatus == sheetTypeStatus)&&const DeepCollectionEquality().equals(other.sheetTypeOptions, sheetTypeOptions)&&(identical(other.transfersStatus, transfersStatus) || other.transfersStatus == transfersStatus)&&const DeepCollectionEquality().equals(other.transferOptions, transferOptions)&&const DeepCollectionEquality().equals(other.selectedTransferIds, selectedTransferIds)&&(identical(other.jobDescription, jobDescription) || other.jobDescription == jobDescription)&&(identical(other.jobComment, jobComment) || other.jobComment == jobComment)&&(identical(other.shippingInstructions, shippingInstructions) || other.shippingInstructions == shippingInstructions)&&(identical(other.requestedShipDate, requestedShipDate) || other.requestedShipDate == requestedShipDate)&&(identical(other.mustShipByRequestedDate, mustShipByRequestedDate) || other.mustShipByRequestedDate == mustShipByRequestedDate)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.shipLine1, shipLine1) || other.shipLine1 == shipLine1)&&(identical(other.shipLine2, shipLine2) || other.shipLine2 == shipLine2)&&(identical(other.shipCity, shipCity) || other.shipCity == shipCity)&&(identical(other.shipState, shipState) || other.shipState == shipState)&&(identical(other.shipZip, shipZip) || other.shipZip == shipZip)&&(identical(other.billLine1, billLine1) || other.billLine1 == billLine1)&&(identical(other.billLine2, billLine2) || other.billLine2 == billLine2)&&(identical(other.billCity, billCity) || other.billCity == billCity)&&(identical(other.billState, billState) || other.billState == billState)&&(identical(other.billZip, billZip) || other.billZip == billZip)&&(identical(other.customerNotes, customerNotes) || other.customerNotes == customerNotes)&&(identical(other.artworkDescription, artworkDescription) || other.artworkDescription == artworkDescription)&&(identical(other.numberOfLocations, numberOfLocations) || other.numberOfLocations == numberOfLocations)&&(identical(other.desiredShipDate, desiredShipDate) || other.desiredShipDate == desiredShipDate));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,type,shipViaStatus,const DeepCollectionEquality().hash(shipViaOptions),selectedShipViaCode,transferTypeStatus,const DeepCollectionEquality().hash(transferTypeOptions),sheetTypeStatus,const DeepCollectionEquality().hash(sheetTypeOptions),transfersStatus,const DeepCollectionEquality().hash(transferOptions),const DeepCollectionEquality().hash(selectedTransferIds),jobDescription,jobComment,shippingInstructions,requestedShipDate,mustShipByRequestedDate,firstName,lastName,email,phone,companyName,shipLine1,shipLine2,shipCity,shipState,shipZip,billLine1,billLine2,billCity,billState,billZip,customerNotes,artworkDescription,numberOfLocations,desiredShipDate]);

@override
String toString() {
  return 'CheckoutState(status: $status, type: $type, shipViaStatus: $shipViaStatus, shipViaOptions: $shipViaOptions, selectedShipViaCode: $selectedShipViaCode, transferTypeStatus: $transferTypeStatus, transferTypeOptions: $transferTypeOptions, sheetTypeStatus: $sheetTypeStatus, sheetTypeOptions: $sheetTypeOptions, transfersStatus: $transfersStatus, transferOptions: $transferOptions, selectedTransferIds: $selectedTransferIds, jobDescription: $jobDescription, jobComment: $jobComment, shippingInstructions: $shippingInstructions, requestedShipDate: $requestedShipDate, mustShipByRequestedDate: $mustShipByRequestedDate, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, companyName: $companyName, shipLine1: $shipLine1, shipLine2: $shipLine2, shipCity: $shipCity, shipState: $shipState, shipZip: $shipZip, billLine1: $billLine1, billLine2: $billLine2, billCity: $billCity, billState: $billState, billZip: $billZip, customerNotes: $customerNotes, artworkDescription: $artworkDescription, numberOfLocations: $numberOfLocations, desiredShipDate: $desiredShipDate)';
}


}

/// @nodoc
abstract mixin class $CheckoutStateCopyWith<$Res>  {
  factory $CheckoutStateCopyWith(CheckoutState value, $Res Function(CheckoutState) _then) = _$CheckoutStateCopyWithImpl;
@useResult
$Res call({
 Result<void> status, CheckoutType type, Result<List<ShipViaOptionEntity>> shipViaStatus, List<ShipViaOptionEntity> shipViaOptions, String? selectedShipViaCode, Result<List<ShipViaOptionEntity>> transferTypeStatus, List<ShipViaOptionEntity> transferTypeOptions, Result<List<ShipViaOptionEntity>> sheetTypeStatus, List<ShipViaOptionEntity> sheetTypeOptions, Result<List<TransferEntity>> transfersStatus, List<TransferEntity> transferOptions, List<int> selectedTransferIds, String jobDescription, String jobComment, String shippingInstructions, DateTime? requestedShipDate, bool mustShipByRequestedDate, String firstName, String lastName, String email, String phone, String companyName, String shipLine1, String shipLine2, String shipCity, String shipState, String shipZip, String billLine1, String billLine2, String billCity, String billState, String billZip, String customerNotes, String artworkDescription, String numberOfLocations, DateTime? desiredShipDate
});


$ResultCopyWith<void, $Res> get status;$ResultCopyWith<List<ShipViaOptionEntity>, $Res> get shipViaStatus;$ResultCopyWith<List<ShipViaOptionEntity>, $Res> get transferTypeStatus;$ResultCopyWith<List<ShipViaOptionEntity>, $Res> get sheetTypeStatus;$ResultCopyWith<List<TransferEntity>, $Res> get transfersStatus;

}
/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._self, this._then);

  final CheckoutState _self;
  final $Res Function(CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? type = null,Object? shipViaStatus = null,Object? shipViaOptions = null,Object? selectedShipViaCode = freezed,Object? transferTypeStatus = null,Object? transferTypeOptions = null,Object? sheetTypeStatus = null,Object? sheetTypeOptions = null,Object? transfersStatus = null,Object? transferOptions = null,Object? selectedTransferIds = null,Object? jobDescription = null,Object? jobComment = null,Object? shippingInstructions = null,Object? requestedShipDate = freezed,Object? mustShipByRequestedDate = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? companyName = null,Object? shipLine1 = null,Object? shipLine2 = null,Object? shipCity = null,Object? shipState = null,Object? shipZip = null,Object? billLine1 = null,Object? billLine2 = null,Object? billCity = null,Object? billState = null,Object? billZip = null,Object? customerNotes = null,Object? artworkDescription = null,Object? numberOfLocations = null,Object? desiredShipDate = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Result<void>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CheckoutType,shipViaStatus: null == shipViaStatus ? _self.shipViaStatus : shipViaStatus // ignore: cast_nullable_to_non_nullable
as Result<List<ShipViaOptionEntity>>,shipViaOptions: null == shipViaOptions ? _self.shipViaOptions : shipViaOptions // ignore: cast_nullable_to_non_nullable
as List<ShipViaOptionEntity>,selectedShipViaCode: freezed == selectedShipViaCode ? _self.selectedShipViaCode : selectedShipViaCode // ignore: cast_nullable_to_non_nullable
as String?,transferTypeStatus: null == transferTypeStatus ? _self.transferTypeStatus : transferTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<ShipViaOptionEntity>>,transferTypeOptions: null == transferTypeOptions ? _self.transferTypeOptions : transferTypeOptions // ignore: cast_nullable_to_non_nullable
as List<ShipViaOptionEntity>,sheetTypeStatus: null == sheetTypeStatus ? _self.sheetTypeStatus : sheetTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<ShipViaOptionEntity>>,sheetTypeOptions: null == sheetTypeOptions ? _self.sheetTypeOptions : sheetTypeOptions // ignore: cast_nullable_to_non_nullable
as List<ShipViaOptionEntity>,transfersStatus: null == transfersStatus ? _self.transfersStatus : transfersStatus // ignore: cast_nullable_to_non_nullable
as Result<List<TransferEntity>>,transferOptions: null == transferOptions ? _self.transferOptions : transferOptions // ignore: cast_nullable_to_non_nullable
as List<TransferEntity>,selectedTransferIds: null == selectedTransferIds ? _self.selectedTransferIds : selectedTransferIds // ignore: cast_nullable_to_non_nullable
as List<int>,jobDescription: null == jobDescription ? _self.jobDescription : jobDescription // ignore: cast_nullable_to_non_nullable
as String,jobComment: null == jobComment ? _self.jobComment : jobComment // ignore: cast_nullable_to_non_nullable
as String,shippingInstructions: null == shippingInstructions ? _self.shippingInstructions : shippingInstructions // ignore: cast_nullable_to_non_nullable
as String,requestedShipDate: freezed == requestedShipDate ? _self.requestedShipDate : requestedShipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,mustShipByRequestedDate: null == mustShipByRequestedDate ? _self.mustShipByRequestedDate : mustShipByRequestedDate // ignore: cast_nullable_to_non_nullable
as bool,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,shipLine1: null == shipLine1 ? _self.shipLine1 : shipLine1 // ignore: cast_nullable_to_non_nullable
as String,shipLine2: null == shipLine2 ? _self.shipLine2 : shipLine2 // ignore: cast_nullable_to_non_nullable
as String,shipCity: null == shipCity ? _self.shipCity : shipCity // ignore: cast_nullable_to_non_nullable
as String,shipState: null == shipState ? _self.shipState : shipState // ignore: cast_nullable_to_non_nullable
as String,shipZip: null == shipZip ? _self.shipZip : shipZip // ignore: cast_nullable_to_non_nullable
as String,billLine1: null == billLine1 ? _self.billLine1 : billLine1 // ignore: cast_nullable_to_non_nullable
as String,billLine2: null == billLine2 ? _self.billLine2 : billLine2 // ignore: cast_nullable_to_non_nullable
as String,billCity: null == billCity ? _self.billCity : billCity // ignore: cast_nullable_to_non_nullable
as String,billState: null == billState ? _self.billState : billState // ignore: cast_nullable_to_non_nullable
as String,billZip: null == billZip ? _self.billZip : billZip // ignore: cast_nullable_to_non_nullable
as String,customerNotes: null == customerNotes ? _self.customerNotes : customerNotes // ignore: cast_nullable_to_non_nullable
as String,artworkDescription: null == artworkDescription ? _self.artworkDescription : artworkDescription // ignore: cast_nullable_to_non_nullable
as String,numberOfLocations: null == numberOfLocations ? _self.numberOfLocations : numberOfLocations // ignore: cast_nullable_to_non_nullable
as String,desiredShipDate: freezed == desiredShipDate ? _self.desiredShipDate : desiredShipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<void, $Res> get status {
  
  return $ResultCopyWith<void, $Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<ShipViaOptionEntity>, $Res> get shipViaStatus {
  
  return $ResultCopyWith<List<ShipViaOptionEntity>, $Res>(_self.shipViaStatus, (value) {
    return _then(_self.copyWith(shipViaStatus: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<ShipViaOptionEntity>, $Res> get transferTypeStatus {
  
  return $ResultCopyWith<List<ShipViaOptionEntity>, $Res>(_self.transferTypeStatus, (value) {
    return _then(_self.copyWith(transferTypeStatus: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<ShipViaOptionEntity>, $Res> get sheetTypeStatus {
  
  return $ResultCopyWith<List<ShipViaOptionEntity>, $Res>(_self.sheetTypeStatus, (value) {
    return _then(_self.copyWith(sheetTypeStatus: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<TransferEntity>, $Res> get transfersStatus {
  
  return $ResultCopyWith<List<TransferEntity>, $Res>(_self.transfersStatus, (value) {
    return _then(_self.copyWith(transfersStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutState value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutState value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Result<void> status,  CheckoutType type,  Result<List<ShipViaOptionEntity>> shipViaStatus,  List<ShipViaOptionEntity> shipViaOptions,  String? selectedShipViaCode,  Result<List<ShipViaOptionEntity>> transferTypeStatus,  List<ShipViaOptionEntity> transferTypeOptions,  Result<List<ShipViaOptionEntity>> sheetTypeStatus,  List<ShipViaOptionEntity> sheetTypeOptions,  Result<List<TransferEntity>> transfersStatus,  List<TransferEntity> transferOptions,  List<int> selectedTransferIds,  String jobDescription,  String jobComment,  String shippingInstructions,  DateTime? requestedShipDate,  bool mustShipByRequestedDate,  String firstName,  String lastName,  String email,  String phone,  String companyName,  String shipLine1,  String shipLine2,  String shipCity,  String shipState,  String shipZip,  String billLine1,  String billLine2,  String billCity,  String billState,  String billZip,  String customerNotes,  String artworkDescription,  String numberOfLocations,  DateTime? desiredShipDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.status,_that.type,_that.shipViaStatus,_that.shipViaOptions,_that.selectedShipViaCode,_that.transferTypeStatus,_that.transferTypeOptions,_that.sheetTypeStatus,_that.sheetTypeOptions,_that.transfersStatus,_that.transferOptions,_that.selectedTransferIds,_that.jobDescription,_that.jobComment,_that.shippingInstructions,_that.requestedShipDate,_that.mustShipByRequestedDate,_that.firstName,_that.lastName,_that.email,_that.phone,_that.companyName,_that.shipLine1,_that.shipLine2,_that.shipCity,_that.shipState,_that.shipZip,_that.billLine1,_that.billLine2,_that.billCity,_that.billState,_that.billZip,_that.customerNotes,_that.artworkDescription,_that.numberOfLocations,_that.desiredShipDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Result<void> status,  CheckoutType type,  Result<List<ShipViaOptionEntity>> shipViaStatus,  List<ShipViaOptionEntity> shipViaOptions,  String? selectedShipViaCode,  Result<List<ShipViaOptionEntity>> transferTypeStatus,  List<ShipViaOptionEntity> transferTypeOptions,  Result<List<ShipViaOptionEntity>> sheetTypeStatus,  List<ShipViaOptionEntity> sheetTypeOptions,  Result<List<TransferEntity>> transfersStatus,  List<TransferEntity> transferOptions,  List<int> selectedTransferIds,  String jobDescription,  String jobComment,  String shippingInstructions,  DateTime? requestedShipDate,  bool mustShipByRequestedDate,  String firstName,  String lastName,  String email,  String phone,  String companyName,  String shipLine1,  String shipLine2,  String shipCity,  String shipState,  String shipZip,  String billLine1,  String billLine2,  String billCity,  String billState,  String billZip,  String customerNotes,  String artworkDescription,  String numberOfLocations,  DateTime? desiredShipDate)  $default,) {final _that = this;
switch (_that) {
case _CheckoutState():
return $default(_that.status,_that.type,_that.shipViaStatus,_that.shipViaOptions,_that.selectedShipViaCode,_that.transferTypeStatus,_that.transferTypeOptions,_that.sheetTypeStatus,_that.sheetTypeOptions,_that.transfersStatus,_that.transferOptions,_that.selectedTransferIds,_that.jobDescription,_that.jobComment,_that.shippingInstructions,_that.requestedShipDate,_that.mustShipByRequestedDate,_that.firstName,_that.lastName,_that.email,_that.phone,_that.companyName,_that.shipLine1,_that.shipLine2,_that.shipCity,_that.shipState,_that.shipZip,_that.billLine1,_that.billLine2,_that.billCity,_that.billState,_that.billZip,_that.customerNotes,_that.artworkDescription,_that.numberOfLocations,_that.desiredShipDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Result<void> status,  CheckoutType type,  Result<List<ShipViaOptionEntity>> shipViaStatus,  List<ShipViaOptionEntity> shipViaOptions,  String? selectedShipViaCode,  Result<List<ShipViaOptionEntity>> transferTypeStatus,  List<ShipViaOptionEntity> transferTypeOptions,  Result<List<ShipViaOptionEntity>> sheetTypeStatus,  List<ShipViaOptionEntity> sheetTypeOptions,  Result<List<TransferEntity>> transfersStatus,  List<TransferEntity> transferOptions,  List<int> selectedTransferIds,  String jobDescription,  String jobComment,  String shippingInstructions,  DateTime? requestedShipDate,  bool mustShipByRequestedDate,  String firstName,  String lastName,  String email,  String phone,  String companyName,  String shipLine1,  String shipLine2,  String shipCity,  String shipState,  String shipZip,  String billLine1,  String billLine2,  String billCity,  String billState,  String billZip,  String customerNotes,  String artworkDescription,  String numberOfLocations,  DateTime? desiredShipDate)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.status,_that.type,_that.shipViaStatus,_that.shipViaOptions,_that.selectedShipViaCode,_that.transferTypeStatus,_that.transferTypeOptions,_that.sheetTypeStatus,_that.sheetTypeOptions,_that.transfersStatus,_that.transferOptions,_that.selectedTransferIds,_that.jobDescription,_that.jobComment,_that.shippingInstructions,_that.requestedShipDate,_that.mustShipByRequestedDate,_that.firstName,_that.lastName,_that.email,_that.phone,_that.companyName,_that.shipLine1,_that.shipLine2,_that.shipCity,_that.shipState,_that.shipZip,_that.billLine1,_that.billLine2,_that.billCity,_that.billState,_that.billZip,_that.customerNotes,_that.artworkDescription,_that.numberOfLocations,_that.desiredShipDate);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutState implements CheckoutState {
  const _CheckoutState({this.status = const Result.empty(), this.type = CheckoutType.requestQuote, this.shipViaStatus = const Result.empty(), final  List<ShipViaOptionEntity> shipViaOptions = const <ShipViaOptionEntity>[], this.selectedShipViaCode, this.transferTypeStatus = const Result.empty(), final  List<ShipViaOptionEntity> transferTypeOptions = const <ShipViaOptionEntity>[], this.sheetTypeStatus = const Result.empty(), final  List<ShipViaOptionEntity> sheetTypeOptions = const <ShipViaOptionEntity>[], this.transfersStatus = const Result.empty(), final  List<TransferEntity> transferOptions = const <TransferEntity>[], final  List<int> selectedTransferIds = const <int>[], this.jobDescription = '', this.jobComment = '', this.shippingInstructions = '', this.requestedShipDate = null, this.mustShipByRequestedDate = false, this.firstName = '', this.lastName = '', this.email = '', this.phone = '', this.companyName = '', this.shipLine1 = '', this.shipLine2 = '', this.shipCity = '', this.shipState = '', this.shipZip = '', this.billLine1 = '', this.billLine2 = '', this.billCity = '', this.billState = '', this.billZip = '', this.customerNotes = '', this.artworkDescription = '', this.numberOfLocations = '1', this.desiredShipDate = null}): _shipViaOptions = shipViaOptions,_transferTypeOptions = transferTypeOptions,_sheetTypeOptions = sheetTypeOptions,_transferOptions = transferOptions,_selectedTransferIds = selectedTransferIds;
  

@override@JsonKey() final  Result<void> status;
@override@JsonKey() final  CheckoutType type;
@override@JsonKey() final  Result<List<ShipViaOptionEntity>> shipViaStatus;
 final  List<ShipViaOptionEntity> _shipViaOptions;
@override@JsonKey() List<ShipViaOptionEntity> get shipViaOptions {
  if (_shipViaOptions is EqualUnmodifiableListView) return _shipViaOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shipViaOptions);
}

@override final  String? selectedShipViaCode;
@override@JsonKey() final  Result<List<ShipViaOptionEntity>> transferTypeStatus;
 final  List<ShipViaOptionEntity> _transferTypeOptions;
@override@JsonKey() List<ShipViaOptionEntity> get transferTypeOptions {
  if (_transferTypeOptions is EqualUnmodifiableListView) return _transferTypeOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transferTypeOptions);
}

@override@JsonKey() final  Result<List<ShipViaOptionEntity>> sheetTypeStatus;
 final  List<ShipViaOptionEntity> _sheetTypeOptions;
@override@JsonKey() List<ShipViaOptionEntity> get sheetTypeOptions {
  if (_sheetTypeOptions is EqualUnmodifiableListView) return _sheetTypeOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sheetTypeOptions);
}

@override@JsonKey() final  Result<List<TransferEntity>> transfersStatus;
 final  List<TransferEntity> _transferOptions;
@override@JsonKey() List<TransferEntity> get transferOptions {
  if (_transferOptions is EqualUnmodifiableListView) return _transferOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transferOptions);
}

 final  List<int> _selectedTransferIds;
@override@JsonKey() List<int> get selectedTransferIds {
  if (_selectedTransferIds is EqualUnmodifiableListView) return _selectedTransferIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedTransferIds);
}

@override@JsonKey() final  String jobDescription;
@override@JsonKey() final  String jobComment;
@override@JsonKey() final  String shippingInstructions;
@override@JsonKey() final  DateTime? requestedShipDate;
@override@JsonKey() final  bool mustShipByRequestedDate;
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
@override@JsonKey() final  String billLine1;
@override@JsonKey() final  String billLine2;
@override@JsonKey() final  String billCity;
@override@JsonKey() final  String billState;
@override@JsonKey() final  String billZip;
@override@JsonKey() final  String customerNotes;
@override@JsonKey() final  String artworkDescription;
@override@JsonKey() final  String numberOfLocations;
@override@JsonKey() final  DateTime? desiredShipDate;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutStateCopyWith<_CheckoutState> get copyWith => __$CheckoutStateCopyWithImpl<_CheckoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutState&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.shipViaStatus, shipViaStatus) || other.shipViaStatus == shipViaStatus)&&const DeepCollectionEquality().equals(other._shipViaOptions, _shipViaOptions)&&(identical(other.selectedShipViaCode, selectedShipViaCode) || other.selectedShipViaCode == selectedShipViaCode)&&(identical(other.transferTypeStatus, transferTypeStatus) || other.transferTypeStatus == transferTypeStatus)&&const DeepCollectionEquality().equals(other._transferTypeOptions, _transferTypeOptions)&&(identical(other.sheetTypeStatus, sheetTypeStatus) || other.sheetTypeStatus == sheetTypeStatus)&&const DeepCollectionEquality().equals(other._sheetTypeOptions, _sheetTypeOptions)&&(identical(other.transfersStatus, transfersStatus) || other.transfersStatus == transfersStatus)&&const DeepCollectionEquality().equals(other._transferOptions, _transferOptions)&&const DeepCollectionEquality().equals(other._selectedTransferIds, _selectedTransferIds)&&(identical(other.jobDescription, jobDescription) || other.jobDescription == jobDescription)&&(identical(other.jobComment, jobComment) || other.jobComment == jobComment)&&(identical(other.shippingInstructions, shippingInstructions) || other.shippingInstructions == shippingInstructions)&&(identical(other.requestedShipDate, requestedShipDate) || other.requestedShipDate == requestedShipDate)&&(identical(other.mustShipByRequestedDate, mustShipByRequestedDate) || other.mustShipByRequestedDate == mustShipByRequestedDate)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.shipLine1, shipLine1) || other.shipLine1 == shipLine1)&&(identical(other.shipLine2, shipLine2) || other.shipLine2 == shipLine2)&&(identical(other.shipCity, shipCity) || other.shipCity == shipCity)&&(identical(other.shipState, shipState) || other.shipState == shipState)&&(identical(other.shipZip, shipZip) || other.shipZip == shipZip)&&(identical(other.billLine1, billLine1) || other.billLine1 == billLine1)&&(identical(other.billLine2, billLine2) || other.billLine2 == billLine2)&&(identical(other.billCity, billCity) || other.billCity == billCity)&&(identical(other.billState, billState) || other.billState == billState)&&(identical(other.billZip, billZip) || other.billZip == billZip)&&(identical(other.customerNotes, customerNotes) || other.customerNotes == customerNotes)&&(identical(other.artworkDescription, artworkDescription) || other.artworkDescription == artworkDescription)&&(identical(other.numberOfLocations, numberOfLocations) || other.numberOfLocations == numberOfLocations)&&(identical(other.desiredShipDate, desiredShipDate) || other.desiredShipDate == desiredShipDate));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,type,shipViaStatus,const DeepCollectionEquality().hash(_shipViaOptions),selectedShipViaCode,transferTypeStatus,const DeepCollectionEquality().hash(_transferTypeOptions),sheetTypeStatus,const DeepCollectionEquality().hash(_sheetTypeOptions),transfersStatus,const DeepCollectionEquality().hash(_transferOptions),const DeepCollectionEquality().hash(_selectedTransferIds),jobDescription,jobComment,shippingInstructions,requestedShipDate,mustShipByRequestedDate,firstName,lastName,email,phone,companyName,shipLine1,shipLine2,shipCity,shipState,shipZip,billLine1,billLine2,billCity,billState,billZip,customerNotes,artworkDescription,numberOfLocations,desiredShipDate]);

@override
String toString() {
  return 'CheckoutState(status: $status, type: $type, shipViaStatus: $shipViaStatus, shipViaOptions: $shipViaOptions, selectedShipViaCode: $selectedShipViaCode, transferTypeStatus: $transferTypeStatus, transferTypeOptions: $transferTypeOptions, sheetTypeStatus: $sheetTypeStatus, sheetTypeOptions: $sheetTypeOptions, transfersStatus: $transfersStatus, transferOptions: $transferOptions, selectedTransferIds: $selectedTransferIds, jobDescription: $jobDescription, jobComment: $jobComment, shippingInstructions: $shippingInstructions, requestedShipDate: $requestedShipDate, mustShipByRequestedDate: $mustShipByRequestedDate, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, companyName: $companyName, shipLine1: $shipLine1, shipLine2: $shipLine2, shipCity: $shipCity, shipState: $shipState, shipZip: $shipZip, billLine1: $billLine1, billLine2: $billLine2, billCity: $billCity, billState: $billState, billZip: $billZip, customerNotes: $customerNotes, artworkDescription: $artworkDescription, numberOfLocations: $numberOfLocations, desiredShipDate: $desiredShipDate)';
}


}

/// @nodoc
abstract mixin class _$CheckoutStateCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory _$CheckoutStateCopyWith(_CheckoutState value, $Res Function(_CheckoutState) _then) = __$CheckoutStateCopyWithImpl;
@override @useResult
$Res call({
 Result<void> status, CheckoutType type, Result<List<ShipViaOptionEntity>> shipViaStatus, List<ShipViaOptionEntity> shipViaOptions, String? selectedShipViaCode, Result<List<ShipViaOptionEntity>> transferTypeStatus, List<ShipViaOptionEntity> transferTypeOptions, Result<List<ShipViaOptionEntity>> sheetTypeStatus, List<ShipViaOptionEntity> sheetTypeOptions, Result<List<TransferEntity>> transfersStatus, List<TransferEntity> transferOptions, List<int> selectedTransferIds, String jobDescription, String jobComment, String shippingInstructions, DateTime? requestedShipDate, bool mustShipByRequestedDate, String firstName, String lastName, String email, String phone, String companyName, String shipLine1, String shipLine2, String shipCity, String shipState, String shipZip, String billLine1, String billLine2, String billCity, String billState, String billZip, String customerNotes, String artworkDescription, String numberOfLocations, DateTime? desiredShipDate
});


@override $ResultCopyWith<void, $Res> get status;@override $ResultCopyWith<List<ShipViaOptionEntity>, $Res> get shipViaStatus;@override $ResultCopyWith<List<ShipViaOptionEntity>, $Res> get transferTypeStatus;@override $ResultCopyWith<List<ShipViaOptionEntity>, $Res> get sheetTypeStatus;@override $ResultCopyWith<List<TransferEntity>, $Res> get transfersStatus;

}
/// @nodoc
class __$CheckoutStateCopyWithImpl<$Res>
    implements _$CheckoutStateCopyWith<$Res> {
  __$CheckoutStateCopyWithImpl(this._self, this._then);

  final _CheckoutState _self;
  final $Res Function(_CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? type = null,Object? shipViaStatus = null,Object? shipViaOptions = null,Object? selectedShipViaCode = freezed,Object? transferTypeStatus = null,Object? transferTypeOptions = null,Object? sheetTypeStatus = null,Object? sheetTypeOptions = null,Object? transfersStatus = null,Object? transferOptions = null,Object? selectedTransferIds = null,Object? jobDescription = null,Object? jobComment = null,Object? shippingInstructions = null,Object? requestedShipDate = freezed,Object? mustShipByRequestedDate = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? companyName = null,Object? shipLine1 = null,Object? shipLine2 = null,Object? shipCity = null,Object? shipState = null,Object? shipZip = null,Object? billLine1 = null,Object? billLine2 = null,Object? billCity = null,Object? billState = null,Object? billZip = null,Object? customerNotes = null,Object? artworkDescription = null,Object? numberOfLocations = null,Object? desiredShipDate = freezed,}) {
  return _then(_CheckoutState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Result<void>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CheckoutType,shipViaStatus: null == shipViaStatus ? _self.shipViaStatus : shipViaStatus // ignore: cast_nullable_to_non_nullable
as Result<List<ShipViaOptionEntity>>,shipViaOptions: null == shipViaOptions ? _self._shipViaOptions : shipViaOptions // ignore: cast_nullable_to_non_nullable
as List<ShipViaOptionEntity>,selectedShipViaCode: freezed == selectedShipViaCode ? _self.selectedShipViaCode : selectedShipViaCode // ignore: cast_nullable_to_non_nullable
as String?,transferTypeStatus: null == transferTypeStatus ? _self.transferTypeStatus : transferTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<ShipViaOptionEntity>>,transferTypeOptions: null == transferTypeOptions ? _self._transferTypeOptions : transferTypeOptions // ignore: cast_nullable_to_non_nullable
as List<ShipViaOptionEntity>,sheetTypeStatus: null == sheetTypeStatus ? _self.sheetTypeStatus : sheetTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<ShipViaOptionEntity>>,sheetTypeOptions: null == sheetTypeOptions ? _self._sheetTypeOptions : sheetTypeOptions // ignore: cast_nullable_to_non_nullable
as List<ShipViaOptionEntity>,transfersStatus: null == transfersStatus ? _self.transfersStatus : transfersStatus // ignore: cast_nullable_to_non_nullable
as Result<List<TransferEntity>>,transferOptions: null == transferOptions ? _self._transferOptions : transferOptions // ignore: cast_nullable_to_non_nullable
as List<TransferEntity>,selectedTransferIds: null == selectedTransferIds ? _self._selectedTransferIds : selectedTransferIds // ignore: cast_nullable_to_non_nullable
as List<int>,jobDescription: null == jobDescription ? _self.jobDescription : jobDescription // ignore: cast_nullable_to_non_nullable
as String,jobComment: null == jobComment ? _self.jobComment : jobComment // ignore: cast_nullable_to_non_nullable
as String,shippingInstructions: null == shippingInstructions ? _self.shippingInstructions : shippingInstructions // ignore: cast_nullable_to_non_nullable
as String,requestedShipDate: freezed == requestedShipDate ? _self.requestedShipDate : requestedShipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,mustShipByRequestedDate: null == mustShipByRequestedDate ? _self.mustShipByRequestedDate : mustShipByRequestedDate // ignore: cast_nullable_to_non_nullable
as bool,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,shipLine1: null == shipLine1 ? _self.shipLine1 : shipLine1 // ignore: cast_nullable_to_non_nullable
as String,shipLine2: null == shipLine2 ? _self.shipLine2 : shipLine2 // ignore: cast_nullable_to_non_nullable
as String,shipCity: null == shipCity ? _self.shipCity : shipCity // ignore: cast_nullable_to_non_nullable
as String,shipState: null == shipState ? _self.shipState : shipState // ignore: cast_nullable_to_non_nullable
as String,shipZip: null == shipZip ? _self.shipZip : shipZip // ignore: cast_nullable_to_non_nullable
as String,billLine1: null == billLine1 ? _self.billLine1 : billLine1 // ignore: cast_nullable_to_non_nullable
as String,billLine2: null == billLine2 ? _self.billLine2 : billLine2 // ignore: cast_nullable_to_non_nullable
as String,billCity: null == billCity ? _self.billCity : billCity // ignore: cast_nullable_to_non_nullable
as String,billState: null == billState ? _self.billState : billState // ignore: cast_nullable_to_non_nullable
as String,billZip: null == billZip ? _self.billZip : billZip // ignore: cast_nullable_to_non_nullable
as String,customerNotes: null == customerNotes ? _self.customerNotes : customerNotes // ignore: cast_nullable_to_non_nullable
as String,artworkDescription: null == artworkDescription ? _self.artworkDescription : artworkDescription // ignore: cast_nullable_to_non_nullable
as String,numberOfLocations: null == numberOfLocations ? _self.numberOfLocations : numberOfLocations // ignore: cast_nullable_to_non_nullable
as String,desiredShipDate: freezed == desiredShipDate ? _self.desiredShipDate : desiredShipDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<void, $Res> get status {
  
  return $ResultCopyWith<void, $Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<ShipViaOptionEntity>, $Res> get shipViaStatus {
  
  return $ResultCopyWith<List<ShipViaOptionEntity>, $Res>(_self.shipViaStatus, (value) {
    return _then(_self.copyWith(shipViaStatus: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<ShipViaOptionEntity>, $Res> get transferTypeStatus {
  
  return $ResultCopyWith<List<ShipViaOptionEntity>, $Res>(_self.transferTypeStatus, (value) {
    return _then(_self.copyWith(transferTypeStatus: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<ShipViaOptionEntity>, $Res> get sheetTypeStatus {
  
  return $ResultCopyWith<List<ShipViaOptionEntity>, $Res>(_self.sheetTypeStatus, (value) {
    return _then(_self.copyWith(sheetTypeStatus: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<TransferEntity>, $Res> get transfersStatus {
  
  return $ResultCopyWith<List<TransferEntity>, $Res>(_self.transfersStatus, (value) {
    return _then(_self.copyWith(transfersStatus: value));
  });
}
}

// dart format on
