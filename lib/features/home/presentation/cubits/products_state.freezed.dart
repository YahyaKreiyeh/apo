// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsState {

 Result<List<ProductEntity>> get status; List<ProductEntity> get items; int get page; bool get hasMore; bool get isLoadingMore;
/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductsStateCopyWith<ProductsState> get copyWith => _$ProductsStateCopyWithImpl<ProductsState>(this as ProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(items),page,hasMore,isLoadingMore);

@override
String toString() {
  return 'ProductsState(status: $status, items: $items, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $ProductsStateCopyWith<$Res>  {
  factory $ProductsStateCopyWith(ProductsState value, $Res Function(ProductsState) _then) = _$ProductsStateCopyWithImpl;
@useResult
$Res call({
 Result<List<ProductEntity>> status, List<ProductEntity> items, int page, bool hasMore, bool isLoadingMore
});


$ResultCopyWith<List<ProductEntity>, $Res> get status;

}
/// @nodoc
class _$ProductsStateCopyWithImpl<$Res>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._self, this._then);

  final ProductsState _self;
  final $Res Function(ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Result<List<ProductEntity>>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<ProductEntity>, $Res> get status {
  
  return $ResultCopyWith<List<ProductEntity>, $Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductsState].
extension ProductsStatePatterns on ProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductsState value)  $default,){
final _that = this;
switch (_that) {
case _ProductsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Result<List<ProductEntity>> status,  List<ProductEntity> items,  int page,  bool hasMore,  bool isLoadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.status,_that.items,_that.page,_that.hasMore,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Result<List<ProductEntity>> status,  List<ProductEntity> items,  int page,  bool hasMore,  bool isLoadingMore)  $default,) {final _that = this;
switch (_that) {
case _ProductsState():
return $default(_that.status,_that.items,_that.page,_that.hasMore,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Result<List<ProductEntity>> status,  List<ProductEntity> items,  int page,  bool hasMore,  bool isLoadingMore)?  $default,) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.status,_that.items,_that.page,_that.hasMore,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _ProductsState implements ProductsState {
  const _ProductsState({this.status = const Result.empty(), final  List<ProductEntity> items = const [], this.page = 0, this.hasMore = true, this.isLoadingMore = false}): _items = items;
  

@override@JsonKey() final  Result<List<ProductEntity>> status;
 final  List<ProductEntity> _items;
@override@JsonKey() List<ProductEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductsStateCopyWith<_ProductsState> get copyWith => __$ProductsStateCopyWithImpl<_ProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),page,hasMore,isLoadingMore);

@override
String toString() {
  return 'ProductsState(status: $status, items: $items, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$ProductsStateCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$ProductsStateCopyWith(_ProductsState value, $Res Function(_ProductsState) _then) = __$ProductsStateCopyWithImpl;
@override @useResult
$Res call({
 Result<List<ProductEntity>> status, List<ProductEntity> items, int page, bool hasMore, bool isLoadingMore
});


@override $ResultCopyWith<List<ProductEntity>, $Res> get status;

}
/// @nodoc
class __$ProductsStateCopyWithImpl<$Res>
    implements _$ProductsStateCopyWith<$Res> {
  __$ProductsStateCopyWithImpl(this._self, this._then);

  final _ProductsState _self;
  final $Res Function(_ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,}) {
  return _then(_ProductsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Result<List<ProductEntity>>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<List<ProductEntity>, $Res> get status {
  
  return $ResultCopyWith<List<ProductEntity>, $Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
