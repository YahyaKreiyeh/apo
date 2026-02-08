// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartState implements DiagnosticableTreeMixin {

 List<CartItemEntity> get items; Result<void> get addStatus; Result<void> get cartStatus; Result<List<MasterDetailEntity>> get decorationTypeStatus; List<MasterDetailEntity> get decorationTypeOptions; Result<List<MasterDetailEntity>> get heatTransferTypeStatus; List<MasterDetailEntity> get heatTransferTypeOptions; Result<List<MasterDetailEntity>> get screenPrintColorStatus; List<MasterDetailEntity> get screenPrintColorOptions; Result<List<MasterDetailEntity>> get screenPrintGarmentStatus; List<MasterDetailEntity> get screenPrintGarmentOptions; Result<List<MasterDetailEntity>> get screenPrintLocationStatus; List<MasterDetailEntity> get screenPrintLocationOptions; Result<List<MasterDetailEntity>> get leatherColorStatus; List<MasterDetailEntity> get leatherColorOptions; Result<List<MasterDetailEntity>> get patchTypeStatus; List<MasterDetailEntity> get patchTypeOptions; Result<List<MasterDetailEntity>> get labelTypeStatus; List<MasterDetailEntity> get labelTypeOptions; Result<List<MasterDetailEntity>> get embOptionsStatus; List<MasterDetailEntity> get embOptions; Result<List<MasterDetailEntity>> get embTypesStatus; List<MasterDetailEntity> get embTypes; Map<String, List<CartDecorationSelection>> get decorationsByItem;
/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartStateCopyWith<CartState> get copyWith => _$CartStateCopyWithImpl<CartState>(this as CartState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CartState'))
    ..add(DiagnosticsProperty('items', items))..add(DiagnosticsProperty('addStatus', addStatus))..add(DiagnosticsProperty('cartStatus', cartStatus))..add(DiagnosticsProperty('decorationTypeStatus', decorationTypeStatus))..add(DiagnosticsProperty('decorationTypeOptions', decorationTypeOptions))..add(DiagnosticsProperty('heatTransferTypeStatus', heatTransferTypeStatus))..add(DiagnosticsProperty('heatTransferTypeOptions', heatTransferTypeOptions))..add(DiagnosticsProperty('screenPrintColorStatus', screenPrintColorStatus))..add(DiagnosticsProperty('screenPrintColorOptions', screenPrintColorOptions))..add(DiagnosticsProperty('screenPrintGarmentStatus', screenPrintGarmentStatus))..add(DiagnosticsProperty('screenPrintGarmentOptions', screenPrintGarmentOptions))..add(DiagnosticsProperty('screenPrintLocationStatus', screenPrintLocationStatus))..add(DiagnosticsProperty('screenPrintLocationOptions', screenPrintLocationOptions))..add(DiagnosticsProperty('leatherColorStatus', leatherColorStatus))..add(DiagnosticsProperty('leatherColorOptions', leatherColorOptions))..add(DiagnosticsProperty('patchTypeStatus', patchTypeStatus))..add(DiagnosticsProperty('patchTypeOptions', patchTypeOptions))..add(DiagnosticsProperty('labelTypeStatus', labelTypeStatus))..add(DiagnosticsProperty('labelTypeOptions', labelTypeOptions))..add(DiagnosticsProperty('embOptionsStatus', embOptionsStatus))..add(DiagnosticsProperty('embOptions', embOptions))..add(DiagnosticsProperty('embTypesStatus', embTypesStatus))..add(DiagnosticsProperty('embTypes', embTypes))..add(DiagnosticsProperty('decorationsByItem', decorationsByItem));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.addStatus, addStatus) || other.addStatus == addStatus)&&(identical(other.cartStatus, cartStatus) || other.cartStatus == cartStatus)&&(identical(other.decorationTypeStatus, decorationTypeStatus) || other.decorationTypeStatus == decorationTypeStatus)&&const DeepCollectionEquality().equals(other.decorationTypeOptions, decorationTypeOptions)&&(identical(other.heatTransferTypeStatus, heatTransferTypeStatus) || other.heatTransferTypeStatus == heatTransferTypeStatus)&&const DeepCollectionEquality().equals(other.heatTransferTypeOptions, heatTransferTypeOptions)&&(identical(other.screenPrintColorStatus, screenPrintColorStatus) || other.screenPrintColorStatus == screenPrintColorStatus)&&const DeepCollectionEquality().equals(other.screenPrintColorOptions, screenPrintColorOptions)&&(identical(other.screenPrintGarmentStatus, screenPrintGarmentStatus) || other.screenPrintGarmentStatus == screenPrintGarmentStatus)&&const DeepCollectionEquality().equals(other.screenPrintGarmentOptions, screenPrintGarmentOptions)&&(identical(other.screenPrintLocationStatus, screenPrintLocationStatus) || other.screenPrintLocationStatus == screenPrintLocationStatus)&&const DeepCollectionEquality().equals(other.screenPrintLocationOptions, screenPrintLocationOptions)&&(identical(other.leatherColorStatus, leatherColorStatus) || other.leatherColorStatus == leatherColorStatus)&&const DeepCollectionEquality().equals(other.leatherColorOptions, leatherColorOptions)&&(identical(other.patchTypeStatus, patchTypeStatus) || other.patchTypeStatus == patchTypeStatus)&&const DeepCollectionEquality().equals(other.patchTypeOptions, patchTypeOptions)&&(identical(other.labelTypeStatus, labelTypeStatus) || other.labelTypeStatus == labelTypeStatus)&&const DeepCollectionEquality().equals(other.labelTypeOptions, labelTypeOptions)&&(identical(other.embOptionsStatus, embOptionsStatus) || other.embOptionsStatus == embOptionsStatus)&&const DeepCollectionEquality().equals(other.embOptions, embOptions)&&(identical(other.embTypesStatus, embTypesStatus) || other.embTypesStatus == embTypesStatus)&&const DeepCollectionEquality().equals(other.embTypes, embTypes)&&const DeepCollectionEquality().equals(other.decorationsByItem, decorationsByItem));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(items),addStatus,cartStatus,decorationTypeStatus,const DeepCollectionEquality().hash(decorationTypeOptions),heatTransferTypeStatus,const DeepCollectionEquality().hash(heatTransferTypeOptions),screenPrintColorStatus,const DeepCollectionEquality().hash(screenPrintColorOptions),screenPrintGarmentStatus,const DeepCollectionEquality().hash(screenPrintGarmentOptions),screenPrintLocationStatus,const DeepCollectionEquality().hash(screenPrintLocationOptions),leatherColorStatus,const DeepCollectionEquality().hash(leatherColorOptions),patchTypeStatus,const DeepCollectionEquality().hash(patchTypeOptions),labelTypeStatus,const DeepCollectionEquality().hash(labelTypeOptions),embOptionsStatus,const DeepCollectionEquality().hash(embOptions),embTypesStatus,const DeepCollectionEquality().hash(embTypes),const DeepCollectionEquality().hash(decorationsByItem)]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CartState(items: $items, addStatus: $addStatus, cartStatus: $cartStatus, decorationTypeStatus: $decorationTypeStatus, decorationTypeOptions: $decorationTypeOptions, heatTransferTypeStatus: $heatTransferTypeStatus, heatTransferTypeOptions: $heatTransferTypeOptions, screenPrintColorStatus: $screenPrintColorStatus, screenPrintColorOptions: $screenPrintColorOptions, screenPrintGarmentStatus: $screenPrintGarmentStatus, screenPrintGarmentOptions: $screenPrintGarmentOptions, screenPrintLocationStatus: $screenPrintLocationStatus, screenPrintLocationOptions: $screenPrintLocationOptions, leatherColorStatus: $leatherColorStatus, leatherColorOptions: $leatherColorOptions, patchTypeStatus: $patchTypeStatus, patchTypeOptions: $patchTypeOptions, labelTypeStatus: $labelTypeStatus, labelTypeOptions: $labelTypeOptions, embOptionsStatus: $embOptionsStatus, embOptions: $embOptions, embTypesStatus: $embTypesStatus, embTypes: $embTypes, decorationsByItem: $decorationsByItem)';
}


}

/// @nodoc
abstract mixin class $CartStateCopyWith<$Res>  {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) _then) = _$CartStateCopyWithImpl;
@useResult
$Res call({
 List<CartItemEntity> items, Result<void> addStatus, Result<void> cartStatus, Result<List<MasterDetailEntity>> decorationTypeStatus, List<MasterDetailEntity> decorationTypeOptions, Result<List<MasterDetailEntity>> heatTransferTypeStatus, List<MasterDetailEntity> heatTransferTypeOptions, Result<List<MasterDetailEntity>> screenPrintColorStatus, List<MasterDetailEntity> screenPrintColorOptions, Result<List<MasterDetailEntity>> screenPrintGarmentStatus, List<MasterDetailEntity> screenPrintGarmentOptions, Result<List<MasterDetailEntity>> screenPrintLocationStatus, List<MasterDetailEntity> screenPrintLocationOptions, Result<List<MasterDetailEntity>> leatherColorStatus, List<MasterDetailEntity> leatherColorOptions, Result<List<MasterDetailEntity>> patchTypeStatus, List<MasterDetailEntity> patchTypeOptions, Result<List<MasterDetailEntity>> labelTypeStatus, List<MasterDetailEntity> labelTypeOptions, Result<List<MasterDetailEntity>> embOptionsStatus, List<MasterDetailEntity> embOptions, Result<List<MasterDetailEntity>> embTypesStatus, List<MasterDetailEntity> embTypes, Map<String, List<CartDecorationSelection>> decorationsByItem
});


$ResultCopyWith<void, $Res> get addStatus;$ResultCopyWith<void, $Res> get cartStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get decorationTypeStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get heatTransferTypeStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintColorStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintGarmentStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintLocationStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get leatherColorStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get patchTypeStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get labelTypeStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get embOptionsStatus;$ResultCopyWith<List<MasterDetailEntity>, $Res> get embTypesStatus;

}
/// @nodoc
class _$CartStateCopyWithImpl<$Res>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._self, this._then);

  final CartState _self;
  final $Res Function(CartState) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? addStatus = null,Object? cartStatus = null,Object? decorationTypeStatus = null,Object? decorationTypeOptions = null,Object? heatTransferTypeStatus = null,Object? heatTransferTypeOptions = null,Object? screenPrintColorStatus = null,Object? screenPrintColorOptions = null,Object? screenPrintGarmentStatus = null,Object? screenPrintGarmentOptions = null,Object? screenPrintLocationStatus = null,Object? screenPrintLocationOptions = null,Object? leatherColorStatus = null,Object? leatherColorOptions = null,Object? patchTypeStatus = null,Object? patchTypeOptions = null,Object? labelTypeStatus = null,Object? labelTypeOptions = null,Object? embOptionsStatus = null,Object? embOptions = null,Object? embTypesStatus = null,Object? embTypes = null,Object? decorationsByItem = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemEntity>,addStatus: null == addStatus ? _self.addStatus : addStatus // ignore: cast_nullable_to_non_nullable
as Result<void>,cartStatus: null == cartStatus ? _self.cartStatus : cartStatus // ignore: cast_nullable_to_non_nullable
as Result<void>,decorationTypeStatus: null == decorationTypeStatus ? _self.decorationTypeStatus : decorationTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,decorationTypeOptions: null == decorationTypeOptions ? _self.decorationTypeOptions : decorationTypeOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,heatTransferTypeStatus: null == heatTransferTypeStatus ? _self.heatTransferTypeStatus : heatTransferTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,heatTransferTypeOptions: null == heatTransferTypeOptions ? _self.heatTransferTypeOptions : heatTransferTypeOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,screenPrintColorStatus: null == screenPrintColorStatus ? _self.screenPrintColorStatus : screenPrintColorStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,screenPrintColorOptions: null == screenPrintColorOptions ? _self.screenPrintColorOptions : screenPrintColorOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,screenPrintGarmentStatus: null == screenPrintGarmentStatus ? _self.screenPrintGarmentStatus : screenPrintGarmentStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,screenPrintGarmentOptions: null == screenPrintGarmentOptions ? _self.screenPrintGarmentOptions : screenPrintGarmentOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,screenPrintLocationStatus: null == screenPrintLocationStatus ? _self.screenPrintLocationStatus : screenPrintLocationStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,screenPrintLocationOptions: null == screenPrintLocationOptions ? _self.screenPrintLocationOptions : screenPrintLocationOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,leatherColorStatus: null == leatherColorStatus ? _self.leatherColorStatus : leatherColorStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,leatherColorOptions: null == leatherColorOptions ? _self.leatherColorOptions : leatherColorOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,patchTypeStatus: null == patchTypeStatus ? _self.patchTypeStatus : patchTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,patchTypeOptions: null == patchTypeOptions ? _self.patchTypeOptions : patchTypeOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,labelTypeStatus: null == labelTypeStatus ? _self.labelTypeStatus : labelTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,labelTypeOptions: null == labelTypeOptions ? _self.labelTypeOptions : labelTypeOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,embOptionsStatus: null == embOptionsStatus ? _self.embOptionsStatus : embOptionsStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,embOptions: null == embOptions ? _self.embOptions : embOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,embTypesStatus: null == embTypesStatus ? _self.embTypesStatus : embTypesStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,embTypes: null == embTypes ? _self.embTypes : embTypes // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,decorationsByItem: null == decorationsByItem ? _self.decorationsByItem : decorationsByItem // ignore: cast_nullable_to_non_nullable
as Map<String, List<CartDecorationSelection>>,
  ));
}
/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<void, $Res> get addStatus {
  
  return $ResultCopyWith<void, $Res>(_self.addStatus, (value) {
    return _then(_self.copyWith(addStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<void, $Res> get cartStatus {
  
  return $ResultCopyWith<void, $Res>(_self.cartStatus, (value) {
    return _then(_self.copyWith(cartStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get decorationTypeStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.decorationTypeStatus, (value) {
    return _then(_self.copyWith(decorationTypeStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get heatTransferTypeStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.heatTransferTypeStatus, (value) {
    return _then(_self.copyWith(heatTransferTypeStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintColorStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.screenPrintColorStatus, (value) {
    return _then(_self.copyWith(screenPrintColorStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintGarmentStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.screenPrintGarmentStatus, (value) {
    return _then(_self.copyWith(screenPrintGarmentStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintLocationStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.screenPrintLocationStatus, (value) {
    return _then(_self.copyWith(screenPrintLocationStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get leatherColorStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.leatherColorStatus, (value) {
    return _then(_self.copyWith(leatherColorStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get patchTypeStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.patchTypeStatus, (value) {
    return _then(_self.copyWith(patchTypeStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get labelTypeStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.labelTypeStatus, (value) {
    return _then(_self.copyWith(labelTypeStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get embOptionsStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.embOptionsStatus, (value) {
    return _then(_self.copyWith(embOptionsStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get embTypesStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.embTypesStatus, (value) {
    return _then(_self.copyWith(embTypesStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [CartState].
extension CartStatePatterns on CartState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartState value)  $default,){
final _that = this;
switch (_that) {
case _CartState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartState value)?  $default,){
final _that = this;
switch (_that) {
case _CartState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CartItemEntity> items,  Result<void> addStatus,  Result<void> cartStatus,  Result<List<MasterDetailEntity>> decorationTypeStatus,  List<MasterDetailEntity> decorationTypeOptions,  Result<List<MasterDetailEntity>> heatTransferTypeStatus,  List<MasterDetailEntity> heatTransferTypeOptions,  Result<List<MasterDetailEntity>> screenPrintColorStatus,  List<MasterDetailEntity> screenPrintColorOptions,  Result<List<MasterDetailEntity>> screenPrintGarmentStatus,  List<MasterDetailEntity> screenPrintGarmentOptions,  Result<List<MasterDetailEntity>> screenPrintLocationStatus,  List<MasterDetailEntity> screenPrintLocationOptions,  Result<List<MasterDetailEntity>> leatherColorStatus,  List<MasterDetailEntity> leatherColorOptions,  Result<List<MasterDetailEntity>> patchTypeStatus,  List<MasterDetailEntity> patchTypeOptions,  Result<List<MasterDetailEntity>> labelTypeStatus,  List<MasterDetailEntity> labelTypeOptions,  Result<List<MasterDetailEntity>> embOptionsStatus,  List<MasterDetailEntity> embOptions,  Result<List<MasterDetailEntity>> embTypesStatus,  List<MasterDetailEntity> embTypes,  Map<String, List<CartDecorationSelection>> decorationsByItem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartState() when $default != null:
return $default(_that.items,_that.addStatus,_that.cartStatus,_that.decorationTypeStatus,_that.decorationTypeOptions,_that.heatTransferTypeStatus,_that.heatTransferTypeOptions,_that.screenPrintColorStatus,_that.screenPrintColorOptions,_that.screenPrintGarmentStatus,_that.screenPrintGarmentOptions,_that.screenPrintLocationStatus,_that.screenPrintLocationOptions,_that.leatherColorStatus,_that.leatherColorOptions,_that.patchTypeStatus,_that.patchTypeOptions,_that.labelTypeStatus,_that.labelTypeOptions,_that.embOptionsStatus,_that.embOptions,_that.embTypesStatus,_that.embTypes,_that.decorationsByItem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CartItemEntity> items,  Result<void> addStatus,  Result<void> cartStatus,  Result<List<MasterDetailEntity>> decorationTypeStatus,  List<MasterDetailEntity> decorationTypeOptions,  Result<List<MasterDetailEntity>> heatTransferTypeStatus,  List<MasterDetailEntity> heatTransferTypeOptions,  Result<List<MasterDetailEntity>> screenPrintColorStatus,  List<MasterDetailEntity> screenPrintColorOptions,  Result<List<MasterDetailEntity>> screenPrintGarmentStatus,  List<MasterDetailEntity> screenPrintGarmentOptions,  Result<List<MasterDetailEntity>> screenPrintLocationStatus,  List<MasterDetailEntity> screenPrintLocationOptions,  Result<List<MasterDetailEntity>> leatherColorStatus,  List<MasterDetailEntity> leatherColorOptions,  Result<List<MasterDetailEntity>> patchTypeStatus,  List<MasterDetailEntity> patchTypeOptions,  Result<List<MasterDetailEntity>> labelTypeStatus,  List<MasterDetailEntity> labelTypeOptions,  Result<List<MasterDetailEntity>> embOptionsStatus,  List<MasterDetailEntity> embOptions,  Result<List<MasterDetailEntity>> embTypesStatus,  List<MasterDetailEntity> embTypes,  Map<String, List<CartDecorationSelection>> decorationsByItem)  $default,) {final _that = this;
switch (_that) {
case _CartState():
return $default(_that.items,_that.addStatus,_that.cartStatus,_that.decorationTypeStatus,_that.decorationTypeOptions,_that.heatTransferTypeStatus,_that.heatTransferTypeOptions,_that.screenPrintColorStatus,_that.screenPrintColorOptions,_that.screenPrintGarmentStatus,_that.screenPrintGarmentOptions,_that.screenPrintLocationStatus,_that.screenPrintLocationOptions,_that.leatherColorStatus,_that.leatherColorOptions,_that.patchTypeStatus,_that.patchTypeOptions,_that.labelTypeStatus,_that.labelTypeOptions,_that.embOptionsStatus,_that.embOptions,_that.embTypesStatus,_that.embTypes,_that.decorationsByItem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CartItemEntity> items,  Result<void> addStatus,  Result<void> cartStatus,  Result<List<MasterDetailEntity>> decorationTypeStatus,  List<MasterDetailEntity> decorationTypeOptions,  Result<List<MasterDetailEntity>> heatTransferTypeStatus,  List<MasterDetailEntity> heatTransferTypeOptions,  Result<List<MasterDetailEntity>> screenPrintColorStatus,  List<MasterDetailEntity> screenPrintColorOptions,  Result<List<MasterDetailEntity>> screenPrintGarmentStatus,  List<MasterDetailEntity> screenPrintGarmentOptions,  Result<List<MasterDetailEntity>> screenPrintLocationStatus,  List<MasterDetailEntity> screenPrintLocationOptions,  Result<List<MasterDetailEntity>> leatherColorStatus,  List<MasterDetailEntity> leatherColorOptions,  Result<List<MasterDetailEntity>> patchTypeStatus,  List<MasterDetailEntity> patchTypeOptions,  Result<List<MasterDetailEntity>> labelTypeStatus,  List<MasterDetailEntity> labelTypeOptions,  Result<List<MasterDetailEntity>> embOptionsStatus,  List<MasterDetailEntity> embOptions,  Result<List<MasterDetailEntity>> embTypesStatus,  List<MasterDetailEntity> embTypes,  Map<String, List<CartDecorationSelection>> decorationsByItem)?  $default,) {final _that = this;
switch (_that) {
case _CartState() when $default != null:
return $default(_that.items,_that.addStatus,_that.cartStatus,_that.decorationTypeStatus,_that.decorationTypeOptions,_that.heatTransferTypeStatus,_that.heatTransferTypeOptions,_that.screenPrintColorStatus,_that.screenPrintColorOptions,_that.screenPrintGarmentStatus,_that.screenPrintGarmentOptions,_that.screenPrintLocationStatus,_that.screenPrintLocationOptions,_that.leatherColorStatus,_that.leatherColorOptions,_that.patchTypeStatus,_that.patchTypeOptions,_that.labelTypeStatus,_that.labelTypeOptions,_that.embOptionsStatus,_that.embOptions,_that.embTypesStatus,_that.embTypes,_that.decorationsByItem);case _:
  return null;

}
}

}

/// @nodoc


class _CartState with DiagnosticableTreeMixin implements CartState {
  const _CartState({final  List<CartItemEntity> items = const [], this.addStatus = const Result.empty(), this.cartStatus = const Result.empty(), this.decorationTypeStatus = const Result.empty(), final  List<MasterDetailEntity> decorationTypeOptions = const <MasterDetailEntity>[], this.heatTransferTypeStatus = const Result.empty(), final  List<MasterDetailEntity> heatTransferTypeOptions = const <MasterDetailEntity>[], this.screenPrintColorStatus = const Result.empty(), final  List<MasterDetailEntity> screenPrintColorOptions = const <MasterDetailEntity>[], this.screenPrintGarmentStatus = const Result.empty(), final  List<MasterDetailEntity> screenPrintGarmentOptions = const <MasterDetailEntity>[], this.screenPrintLocationStatus = const Result.empty(), final  List<MasterDetailEntity> screenPrintLocationOptions = const <MasterDetailEntity>[], this.leatherColorStatus = const Result.empty(), final  List<MasterDetailEntity> leatherColorOptions = const <MasterDetailEntity>[], this.patchTypeStatus = const Result.empty(), final  List<MasterDetailEntity> patchTypeOptions = const <MasterDetailEntity>[], this.labelTypeStatus = const Result.empty(), final  List<MasterDetailEntity> labelTypeOptions = const <MasterDetailEntity>[], this.embOptionsStatus = const Result.empty(), final  List<MasterDetailEntity> embOptions = const <MasterDetailEntity>[], this.embTypesStatus = const Result.empty(), final  List<MasterDetailEntity> embTypes = const <MasterDetailEntity>[], final  Map<String, List<CartDecorationSelection>> decorationsByItem = const <String, List<CartDecorationSelection>>{}}): _items = items,_decorationTypeOptions = decorationTypeOptions,_heatTransferTypeOptions = heatTransferTypeOptions,_screenPrintColorOptions = screenPrintColorOptions,_screenPrintGarmentOptions = screenPrintGarmentOptions,_screenPrintLocationOptions = screenPrintLocationOptions,_leatherColorOptions = leatherColorOptions,_patchTypeOptions = patchTypeOptions,_labelTypeOptions = labelTypeOptions,_embOptions = embOptions,_embTypes = embTypes,_decorationsByItem = decorationsByItem;
  

 final  List<CartItemEntity> _items;
@override@JsonKey() List<CartItemEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  Result<void> addStatus;
@override@JsonKey() final  Result<void> cartStatus;
@override@JsonKey() final  Result<List<MasterDetailEntity>> decorationTypeStatus;
 final  List<MasterDetailEntity> _decorationTypeOptions;
@override@JsonKey() List<MasterDetailEntity> get decorationTypeOptions {
  if (_decorationTypeOptions is EqualUnmodifiableListView) return _decorationTypeOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_decorationTypeOptions);
}

@override@JsonKey() final  Result<List<MasterDetailEntity>> heatTransferTypeStatus;
 final  List<MasterDetailEntity> _heatTransferTypeOptions;
@override@JsonKey() List<MasterDetailEntity> get heatTransferTypeOptions {
  if (_heatTransferTypeOptions is EqualUnmodifiableListView) return _heatTransferTypeOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_heatTransferTypeOptions);
}

@override@JsonKey() final  Result<List<MasterDetailEntity>> screenPrintColorStatus;
 final  List<MasterDetailEntity> _screenPrintColorOptions;
@override@JsonKey() List<MasterDetailEntity> get screenPrintColorOptions {
  if (_screenPrintColorOptions is EqualUnmodifiableListView) return _screenPrintColorOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_screenPrintColorOptions);
}

@override@JsonKey() final  Result<List<MasterDetailEntity>> screenPrintGarmentStatus;
 final  List<MasterDetailEntity> _screenPrintGarmentOptions;
@override@JsonKey() List<MasterDetailEntity> get screenPrintGarmentOptions {
  if (_screenPrintGarmentOptions is EqualUnmodifiableListView) return _screenPrintGarmentOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_screenPrintGarmentOptions);
}

@override@JsonKey() final  Result<List<MasterDetailEntity>> screenPrintLocationStatus;
 final  List<MasterDetailEntity> _screenPrintLocationOptions;
@override@JsonKey() List<MasterDetailEntity> get screenPrintLocationOptions {
  if (_screenPrintLocationOptions is EqualUnmodifiableListView) return _screenPrintLocationOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_screenPrintLocationOptions);
}

@override@JsonKey() final  Result<List<MasterDetailEntity>> leatherColorStatus;
 final  List<MasterDetailEntity> _leatherColorOptions;
@override@JsonKey() List<MasterDetailEntity> get leatherColorOptions {
  if (_leatherColorOptions is EqualUnmodifiableListView) return _leatherColorOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leatherColorOptions);
}

@override@JsonKey() final  Result<List<MasterDetailEntity>> patchTypeStatus;
 final  List<MasterDetailEntity> _patchTypeOptions;
@override@JsonKey() List<MasterDetailEntity> get patchTypeOptions {
  if (_patchTypeOptions is EqualUnmodifiableListView) return _patchTypeOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_patchTypeOptions);
}

@override@JsonKey() final  Result<List<MasterDetailEntity>> labelTypeStatus;
 final  List<MasterDetailEntity> _labelTypeOptions;
@override@JsonKey() List<MasterDetailEntity> get labelTypeOptions {
  if (_labelTypeOptions is EqualUnmodifiableListView) return _labelTypeOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labelTypeOptions);
}

@override@JsonKey() final  Result<List<MasterDetailEntity>> embOptionsStatus;
 final  List<MasterDetailEntity> _embOptions;
@override@JsonKey() List<MasterDetailEntity> get embOptions {
  if (_embOptions is EqualUnmodifiableListView) return _embOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_embOptions);
}

@override@JsonKey() final  Result<List<MasterDetailEntity>> embTypesStatus;
 final  List<MasterDetailEntity> _embTypes;
@override@JsonKey() List<MasterDetailEntity> get embTypes {
  if (_embTypes is EqualUnmodifiableListView) return _embTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_embTypes);
}

 final  Map<String, List<CartDecorationSelection>> _decorationsByItem;
@override@JsonKey() Map<String, List<CartDecorationSelection>> get decorationsByItem {
  if (_decorationsByItem is EqualUnmodifiableMapView) return _decorationsByItem;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_decorationsByItem);
}


/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartStateCopyWith<_CartState> get copyWith => __$CartStateCopyWithImpl<_CartState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CartState'))
    ..add(DiagnosticsProperty('items', items))..add(DiagnosticsProperty('addStatus', addStatus))..add(DiagnosticsProperty('cartStatus', cartStatus))..add(DiagnosticsProperty('decorationTypeStatus', decorationTypeStatus))..add(DiagnosticsProperty('decorationTypeOptions', decorationTypeOptions))..add(DiagnosticsProperty('heatTransferTypeStatus', heatTransferTypeStatus))..add(DiagnosticsProperty('heatTransferTypeOptions', heatTransferTypeOptions))..add(DiagnosticsProperty('screenPrintColorStatus', screenPrintColorStatus))..add(DiagnosticsProperty('screenPrintColorOptions', screenPrintColorOptions))..add(DiagnosticsProperty('screenPrintGarmentStatus', screenPrintGarmentStatus))..add(DiagnosticsProperty('screenPrintGarmentOptions', screenPrintGarmentOptions))..add(DiagnosticsProperty('screenPrintLocationStatus', screenPrintLocationStatus))..add(DiagnosticsProperty('screenPrintLocationOptions', screenPrintLocationOptions))..add(DiagnosticsProperty('leatherColorStatus', leatherColorStatus))..add(DiagnosticsProperty('leatherColorOptions', leatherColorOptions))..add(DiagnosticsProperty('patchTypeStatus', patchTypeStatus))..add(DiagnosticsProperty('patchTypeOptions', patchTypeOptions))..add(DiagnosticsProperty('labelTypeStatus', labelTypeStatus))..add(DiagnosticsProperty('labelTypeOptions', labelTypeOptions))..add(DiagnosticsProperty('embOptionsStatus', embOptionsStatus))..add(DiagnosticsProperty('embOptions', embOptions))..add(DiagnosticsProperty('embTypesStatus', embTypesStatus))..add(DiagnosticsProperty('embTypes', embTypes))..add(DiagnosticsProperty('decorationsByItem', decorationsByItem));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.addStatus, addStatus) || other.addStatus == addStatus)&&(identical(other.cartStatus, cartStatus) || other.cartStatus == cartStatus)&&(identical(other.decorationTypeStatus, decorationTypeStatus) || other.decorationTypeStatus == decorationTypeStatus)&&const DeepCollectionEquality().equals(other._decorationTypeOptions, _decorationTypeOptions)&&(identical(other.heatTransferTypeStatus, heatTransferTypeStatus) || other.heatTransferTypeStatus == heatTransferTypeStatus)&&const DeepCollectionEquality().equals(other._heatTransferTypeOptions, _heatTransferTypeOptions)&&(identical(other.screenPrintColorStatus, screenPrintColorStatus) || other.screenPrintColorStatus == screenPrintColorStatus)&&const DeepCollectionEquality().equals(other._screenPrintColorOptions, _screenPrintColorOptions)&&(identical(other.screenPrintGarmentStatus, screenPrintGarmentStatus) || other.screenPrintGarmentStatus == screenPrintGarmentStatus)&&const DeepCollectionEquality().equals(other._screenPrintGarmentOptions, _screenPrintGarmentOptions)&&(identical(other.screenPrintLocationStatus, screenPrintLocationStatus) || other.screenPrintLocationStatus == screenPrintLocationStatus)&&const DeepCollectionEquality().equals(other._screenPrintLocationOptions, _screenPrintLocationOptions)&&(identical(other.leatherColorStatus, leatherColorStatus) || other.leatherColorStatus == leatherColorStatus)&&const DeepCollectionEquality().equals(other._leatherColorOptions, _leatherColorOptions)&&(identical(other.patchTypeStatus, patchTypeStatus) || other.patchTypeStatus == patchTypeStatus)&&const DeepCollectionEquality().equals(other._patchTypeOptions, _patchTypeOptions)&&(identical(other.labelTypeStatus, labelTypeStatus) || other.labelTypeStatus == labelTypeStatus)&&const DeepCollectionEquality().equals(other._labelTypeOptions, _labelTypeOptions)&&(identical(other.embOptionsStatus, embOptionsStatus) || other.embOptionsStatus == embOptionsStatus)&&const DeepCollectionEquality().equals(other._embOptions, _embOptions)&&(identical(other.embTypesStatus, embTypesStatus) || other.embTypesStatus == embTypesStatus)&&const DeepCollectionEquality().equals(other._embTypes, _embTypes)&&const DeepCollectionEquality().equals(other._decorationsByItem, _decorationsByItem));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_items),addStatus,cartStatus,decorationTypeStatus,const DeepCollectionEquality().hash(_decorationTypeOptions),heatTransferTypeStatus,const DeepCollectionEquality().hash(_heatTransferTypeOptions),screenPrintColorStatus,const DeepCollectionEquality().hash(_screenPrintColorOptions),screenPrintGarmentStatus,const DeepCollectionEquality().hash(_screenPrintGarmentOptions),screenPrintLocationStatus,const DeepCollectionEquality().hash(_screenPrintLocationOptions),leatherColorStatus,const DeepCollectionEquality().hash(_leatherColorOptions),patchTypeStatus,const DeepCollectionEquality().hash(_patchTypeOptions),labelTypeStatus,const DeepCollectionEquality().hash(_labelTypeOptions),embOptionsStatus,const DeepCollectionEquality().hash(_embOptions),embTypesStatus,const DeepCollectionEquality().hash(_embTypes),const DeepCollectionEquality().hash(_decorationsByItem)]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CartState(items: $items, addStatus: $addStatus, cartStatus: $cartStatus, decorationTypeStatus: $decorationTypeStatus, decorationTypeOptions: $decorationTypeOptions, heatTransferTypeStatus: $heatTransferTypeStatus, heatTransferTypeOptions: $heatTransferTypeOptions, screenPrintColorStatus: $screenPrintColorStatus, screenPrintColorOptions: $screenPrintColorOptions, screenPrintGarmentStatus: $screenPrintGarmentStatus, screenPrintGarmentOptions: $screenPrintGarmentOptions, screenPrintLocationStatus: $screenPrintLocationStatus, screenPrintLocationOptions: $screenPrintLocationOptions, leatherColorStatus: $leatherColorStatus, leatherColorOptions: $leatherColorOptions, patchTypeStatus: $patchTypeStatus, patchTypeOptions: $patchTypeOptions, labelTypeStatus: $labelTypeStatus, labelTypeOptions: $labelTypeOptions, embOptionsStatus: $embOptionsStatus, embOptions: $embOptions, embTypesStatus: $embTypesStatus, embTypes: $embTypes, decorationsByItem: $decorationsByItem)';
}


}

/// @nodoc
abstract mixin class _$CartStateCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory _$CartStateCopyWith(_CartState value, $Res Function(_CartState) _then) = __$CartStateCopyWithImpl;
@override @useResult
$Res call({
 List<CartItemEntity> items, Result<void> addStatus, Result<void> cartStatus, Result<List<MasterDetailEntity>> decorationTypeStatus, List<MasterDetailEntity> decorationTypeOptions, Result<List<MasterDetailEntity>> heatTransferTypeStatus, List<MasterDetailEntity> heatTransferTypeOptions, Result<List<MasterDetailEntity>> screenPrintColorStatus, List<MasterDetailEntity> screenPrintColorOptions, Result<List<MasterDetailEntity>> screenPrintGarmentStatus, List<MasterDetailEntity> screenPrintGarmentOptions, Result<List<MasterDetailEntity>> screenPrintLocationStatus, List<MasterDetailEntity> screenPrintLocationOptions, Result<List<MasterDetailEntity>> leatherColorStatus, List<MasterDetailEntity> leatherColorOptions, Result<List<MasterDetailEntity>> patchTypeStatus, List<MasterDetailEntity> patchTypeOptions, Result<List<MasterDetailEntity>> labelTypeStatus, List<MasterDetailEntity> labelTypeOptions, Result<List<MasterDetailEntity>> embOptionsStatus, List<MasterDetailEntity> embOptions, Result<List<MasterDetailEntity>> embTypesStatus, List<MasterDetailEntity> embTypes, Map<String, List<CartDecorationSelection>> decorationsByItem
});


@override $ResultCopyWith<void, $Res> get addStatus;@override $ResultCopyWith<void, $Res> get cartStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get decorationTypeStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get heatTransferTypeStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintColorStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintGarmentStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintLocationStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get leatherColorStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get patchTypeStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get labelTypeStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get embOptionsStatus;@override $ResultCopyWith<List<MasterDetailEntity>, $Res> get embTypesStatus;

}
/// @nodoc
class __$CartStateCopyWithImpl<$Res>
    implements _$CartStateCopyWith<$Res> {
  __$CartStateCopyWithImpl(this._self, this._then);

  final _CartState _self;
  final $Res Function(_CartState) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? addStatus = null,Object? cartStatus = null,Object? decorationTypeStatus = null,Object? decorationTypeOptions = null,Object? heatTransferTypeStatus = null,Object? heatTransferTypeOptions = null,Object? screenPrintColorStatus = null,Object? screenPrintColorOptions = null,Object? screenPrintGarmentStatus = null,Object? screenPrintGarmentOptions = null,Object? screenPrintLocationStatus = null,Object? screenPrintLocationOptions = null,Object? leatherColorStatus = null,Object? leatherColorOptions = null,Object? patchTypeStatus = null,Object? patchTypeOptions = null,Object? labelTypeStatus = null,Object? labelTypeOptions = null,Object? embOptionsStatus = null,Object? embOptions = null,Object? embTypesStatus = null,Object? embTypes = null,Object? decorationsByItem = null,}) {
  return _then(_CartState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemEntity>,addStatus: null == addStatus ? _self.addStatus : addStatus // ignore: cast_nullable_to_non_nullable
as Result<void>,cartStatus: null == cartStatus ? _self.cartStatus : cartStatus // ignore: cast_nullable_to_non_nullable
as Result<void>,decorationTypeStatus: null == decorationTypeStatus ? _self.decorationTypeStatus : decorationTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,decorationTypeOptions: null == decorationTypeOptions ? _self._decorationTypeOptions : decorationTypeOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,heatTransferTypeStatus: null == heatTransferTypeStatus ? _self.heatTransferTypeStatus : heatTransferTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,heatTransferTypeOptions: null == heatTransferTypeOptions ? _self._heatTransferTypeOptions : heatTransferTypeOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,screenPrintColorStatus: null == screenPrintColorStatus ? _self.screenPrintColorStatus : screenPrintColorStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,screenPrintColorOptions: null == screenPrintColorOptions ? _self._screenPrintColorOptions : screenPrintColorOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,screenPrintGarmentStatus: null == screenPrintGarmentStatus ? _self.screenPrintGarmentStatus : screenPrintGarmentStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,screenPrintGarmentOptions: null == screenPrintGarmentOptions ? _self._screenPrintGarmentOptions : screenPrintGarmentOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,screenPrintLocationStatus: null == screenPrintLocationStatus ? _self.screenPrintLocationStatus : screenPrintLocationStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,screenPrintLocationOptions: null == screenPrintLocationOptions ? _self._screenPrintLocationOptions : screenPrintLocationOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,leatherColorStatus: null == leatherColorStatus ? _self.leatherColorStatus : leatherColorStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,leatherColorOptions: null == leatherColorOptions ? _self._leatherColorOptions : leatherColorOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,patchTypeStatus: null == patchTypeStatus ? _self.patchTypeStatus : patchTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,patchTypeOptions: null == patchTypeOptions ? _self._patchTypeOptions : patchTypeOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,labelTypeStatus: null == labelTypeStatus ? _self.labelTypeStatus : labelTypeStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,labelTypeOptions: null == labelTypeOptions ? _self._labelTypeOptions : labelTypeOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,embOptionsStatus: null == embOptionsStatus ? _self.embOptionsStatus : embOptionsStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,embOptions: null == embOptions ? _self._embOptions : embOptions // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,embTypesStatus: null == embTypesStatus ? _self.embTypesStatus : embTypesStatus // ignore: cast_nullable_to_non_nullable
as Result<List<MasterDetailEntity>>,embTypes: null == embTypes ? _self._embTypes : embTypes // ignore: cast_nullable_to_non_nullable
as List<MasterDetailEntity>,decorationsByItem: null == decorationsByItem ? _self._decorationsByItem : decorationsByItem // ignore: cast_nullable_to_non_nullable
as Map<String, List<CartDecorationSelection>>,
  ));
}

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<void, $Res> get addStatus {
  
  return $ResultCopyWith<void, $Res>(_self.addStatus, (value) {
    return _then(_self.copyWith(addStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<void, $Res> get cartStatus {
  
  return $ResultCopyWith<void, $Res>(_self.cartStatus, (value) {
    return _then(_self.copyWith(cartStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get decorationTypeStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.decorationTypeStatus, (value) {
    return _then(_self.copyWith(decorationTypeStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get heatTransferTypeStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.heatTransferTypeStatus, (value) {
    return _then(_self.copyWith(heatTransferTypeStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintColorStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.screenPrintColorStatus, (value) {
    return _then(_self.copyWith(screenPrintColorStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintGarmentStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.screenPrintGarmentStatus, (value) {
    return _then(_self.copyWith(screenPrintGarmentStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get screenPrintLocationStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.screenPrintLocationStatus, (value) {
    return _then(_self.copyWith(screenPrintLocationStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get leatherColorStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.leatherColorStatus, (value) {
    return _then(_self.copyWith(leatherColorStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get patchTypeStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.patchTypeStatus, (value) {
    return _then(_self.copyWith(patchTypeStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get labelTypeStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.labelTypeStatus, (value) {
    return _then(_self.copyWith(labelTypeStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get embOptionsStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.embOptionsStatus, (value) {
    return _then(_self.copyWith(embOptionsStatus: value));
  });
}/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<MasterDetailEntity>, $Res> get embTypesStatus {
  
  return $ResultCopyWith<List<MasterDetailEntity>, $Res>(_self.embTypesStatus, (value) {
    return _then(_self.copyWith(embTypesStatus: value));
  });
}
}

// dart format on
