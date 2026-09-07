// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerState {

 List<Customer> get customers; List<Customer> get customerSearchResults; Customer? get selectedCustomer; List<Enrollment> get enrollments; Enrollment? get selectedEnrollment; CustomerDetailData? get customerDetailData; List<Invoice> get invoices; double get totalDue; bool get isLoading; bool get isSearchingCustomers; bool get isLoadingEnrollments; PaymentResult? get paymentResult; String? get error; String? get successMessage;
/// Create a copy of CustomerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerStateCopyWith<CustomerState> get copyWith => _$CustomerStateCopyWithImpl<CustomerState>(this as CustomerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerState&&const DeepCollectionEquality().equals(other.customers, customers)&&const DeepCollectionEquality().equals(other.customerSearchResults, customerSearchResults)&&(identical(other.selectedCustomer, selectedCustomer) || other.selectedCustomer == selectedCustomer)&&const DeepCollectionEquality().equals(other.enrollments, enrollments)&&(identical(other.selectedEnrollment, selectedEnrollment) || other.selectedEnrollment == selectedEnrollment)&&(identical(other.customerDetailData, customerDetailData) || other.customerDetailData == customerDetailData)&&const DeepCollectionEquality().equals(other.invoices, invoices)&&(identical(other.totalDue, totalDue) || other.totalDue == totalDue)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSearchingCustomers, isSearchingCustomers) || other.isSearchingCustomers == isSearchingCustomers)&&(identical(other.isLoadingEnrollments, isLoadingEnrollments) || other.isLoadingEnrollments == isLoadingEnrollments)&&(identical(other.paymentResult, paymentResult) || other.paymentResult == paymentResult)&&(identical(other.error, error) || other.error == error)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(customers),const DeepCollectionEquality().hash(customerSearchResults),selectedCustomer,const DeepCollectionEquality().hash(enrollments),selectedEnrollment,customerDetailData,const DeepCollectionEquality().hash(invoices),totalDue,isLoading,isSearchingCustomers,isLoadingEnrollments,paymentResult,error,successMessage);

@override
String toString() {
  return 'CustomerState(customers: $customers, customerSearchResults: $customerSearchResults, selectedCustomer: $selectedCustomer, enrollments: $enrollments, selectedEnrollment: $selectedEnrollment, customerDetailData: $customerDetailData, invoices: $invoices, totalDue: $totalDue, isLoading: $isLoading, isSearchingCustomers: $isSearchingCustomers, isLoadingEnrollments: $isLoadingEnrollments, paymentResult: $paymentResult, error: $error, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $CustomerStateCopyWith<$Res>  {
  factory $CustomerStateCopyWith(CustomerState value, $Res Function(CustomerState) _then) = _$CustomerStateCopyWithImpl;
@useResult
$Res call({
 List<Customer> customers, List<Customer> customerSearchResults, Customer? selectedCustomer, List<Enrollment> enrollments, Enrollment? selectedEnrollment, CustomerDetailData? customerDetailData, List<Invoice> invoices, double totalDue, bool isLoading, bool isSearchingCustomers, bool isLoadingEnrollments, PaymentResult? paymentResult, String? error, String? successMessage
});




}
/// @nodoc
class _$CustomerStateCopyWithImpl<$Res>
    implements $CustomerStateCopyWith<$Res> {
  _$CustomerStateCopyWithImpl(this._self, this._then);

  final CustomerState _self;
  final $Res Function(CustomerState) _then;

/// Create a copy of CustomerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customers = null,Object? customerSearchResults = null,Object? selectedCustomer = freezed,Object? enrollments = null,Object? selectedEnrollment = freezed,Object? customerDetailData = freezed,Object? invoices = null,Object? totalDue = null,Object? isLoading = null,Object? isSearchingCustomers = null,Object? isLoadingEnrollments = null,Object? paymentResult = freezed,Object? error = freezed,Object? successMessage = freezed,}) {
  return _then(CustomerState(
customers: null == customers ? _self.customers : customers // ignore: cast_nullable_to_non_nullable
as List<Customer>,customerSearchResults: null == customerSearchResults ? _self.customerSearchResults : customerSearchResults // ignore: cast_nullable_to_non_nullable
as List<Customer>,selectedCustomer: freezed == selectedCustomer ? _self.selectedCustomer : selectedCustomer // ignore: cast_nullable_to_non_nullable
as Customer?,enrollments: null == enrollments ? _self.enrollments : enrollments // ignore: cast_nullable_to_non_nullable
as List<Enrollment>,selectedEnrollment: freezed == selectedEnrollment ? _self.selectedEnrollment : selectedEnrollment // ignore: cast_nullable_to_non_nullable
as Enrollment?,customerDetailData: freezed == customerDetailData ? _self.customerDetailData : customerDetailData // ignore: cast_nullable_to_non_nullable
as CustomerDetailData?,invoices: null == invoices ? _self.invoices : invoices // ignore: cast_nullable_to_non_nullable
as List<Invoice>,totalDue: null == totalDue ? _self.totalDue : totalDue // ignore: cast_nullable_to_non_nullable
as double,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSearchingCustomers: null == isSearchingCustomers ? _self.isSearchingCustomers : isSearchingCustomers // ignore: cast_nullable_to_non_nullable
as bool,isLoadingEnrollments: null == isLoadingEnrollments ? _self.isLoadingEnrollments : isLoadingEnrollments // ignore: cast_nullable_to_non_nullable
as bool,paymentResult: freezed == paymentResult ? _self.paymentResult : paymentResult // ignore: cast_nullable_to_non_nullable
as PaymentResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerState].
extension CustomerStatePatterns on CustomerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerState value)  $default,){
final _that = this;
switch (_that) {
case _CustomerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerState value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Customer> customers,  List<Customer> customerSearchResults,  Customer? selectedCustomer,  List<Enrollment> enrollments,  Enrollment? selectedEnrollment,  CustomerDetailData? customerDetailData,  List<Invoice> invoices,  double totalDue,  bool isLoading,  bool isSearchingCustomers,  bool isLoadingEnrollments,  PaymentResult? paymentResult,  String? error,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerState() when $default != null:
return $default(_that.customers,_that.customerSearchResults,_that.selectedCustomer,_that.enrollments,_that.selectedEnrollment,_that.customerDetailData,_that.invoices,_that.totalDue,_that.isLoading,_that.isSearchingCustomers,_that.isLoadingEnrollments,_that.paymentResult,_that.error,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Customer> customers,  List<Customer> customerSearchResults,  Customer? selectedCustomer,  List<Enrollment> enrollments,  Enrollment? selectedEnrollment,  CustomerDetailData? customerDetailData,  List<Invoice> invoices,  double totalDue,  bool isLoading,  bool isSearchingCustomers,  bool isLoadingEnrollments,  PaymentResult? paymentResult,  String? error,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _CustomerState():
return $default(_that.customers,_that.customerSearchResults,_that.selectedCustomer,_that.enrollments,_that.selectedEnrollment,_that.customerDetailData,_that.invoices,_that.totalDue,_that.isLoading,_that.isSearchingCustomers,_that.isLoadingEnrollments,_that.paymentResult,_that.error,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Customer> customers,  List<Customer> customerSearchResults,  Customer? selectedCustomer,  List<Enrollment> enrollments,  Enrollment? selectedEnrollment,  CustomerDetailData? customerDetailData,  List<Invoice> invoices,  double totalDue,  bool isLoading,  bool isSearchingCustomers,  bool isLoadingEnrollments,  PaymentResult? paymentResult,  String? error,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _CustomerState() when $default != null:
return $default(_that.customers,_that.customerSearchResults,_that.selectedCustomer,_that.enrollments,_that.selectedEnrollment,_that.customerDetailData,_that.invoices,_that.totalDue,_that.isLoading,_that.isSearchingCustomers,_that.isLoadingEnrollments,_that.paymentResult,_that.error,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerState implements CustomerState {
  const _CustomerState({ List<Customer> customers = const [],  List<Customer> customerSearchResults = const [], this.selectedCustomer,  List<Enrollment> enrollments = const [], this.selectedEnrollment, this.customerDetailData,  List<Invoice> invoices = const [], this.totalDue = 0.0, this.isLoading = false, this.isSearchingCustomers = false, this.isLoadingEnrollments = false, this.paymentResult, this.error, this.successMessage}): _customers = customers,_customerSearchResults = customerSearchResults,_enrollments = enrollments,_invoices = invoices;
  

 final  List<Customer> _customers;
@override@JsonKey() List<Customer> get customers {
  if (_customers is EqualUnmodifiableListView) return _customers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customers);
}

 final  List<Customer> _customerSearchResults;
@override@JsonKey() List<Customer> get customerSearchResults {
  if (_customerSearchResults is EqualUnmodifiableListView) return _customerSearchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customerSearchResults);
}

@override final  Customer? selectedCustomer;
 final  List<Enrollment> _enrollments;
@override@JsonKey() List<Enrollment> get enrollments {
  if (_enrollments is EqualUnmodifiableListView) return _enrollments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_enrollments);
}

@override final  Enrollment? selectedEnrollment;
@override final  CustomerDetailData? customerDetailData;
 final  List<Invoice> _invoices;
@override@JsonKey() List<Invoice> get invoices {
  if (_invoices is EqualUnmodifiableListView) return _invoices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invoices);
}

@override@JsonKey() final  double totalDue;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSearchingCustomers;
@override@JsonKey() final  bool isLoadingEnrollments;
@override final  PaymentResult? paymentResult;
@override final  String? error;
@override final  String? successMessage;

/// Create a copy of CustomerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerStateCopyWith<_CustomerState> get copyWith => __$CustomerStateCopyWithImpl<_CustomerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerState&&const DeepCollectionEquality().equals(other._customers, _customers)&&const DeepCollectionEquality().equals(other._customerSearchResults, _customerSearchResults)&&(identical(other.selectedCustomer, selectedCustomer) || other.selectedCustomer == selectedCustomer)&&const DeepCollectionEquality().equals(other._enrollments, _enrollments)&&(identical(other.selectedEnrollment, selectedEnrollment) || other.selectedEnrollment == selectedEnrollment)&&(identical(other.customerDetailData, customerDetailData) || other.customerDetailData == customerDetailData)&&const DeepCollectionEquality().equals(other._invoices, _invoices)&&(identical(other.totalDue, totalDue) || other.totalDue == totalDue)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSearchingCustomers, isSearchingCustomers) || other.isSearchingCustomers == isSearchingCustomers)&&(identical(other.isLoadingEnrollments, isLoadingEnrollments) || other.isLoadingEnrollments == isLoadingEnrollments)&&(identical(other.paymentResult, paymentResult) || other.paymentResult == paymentResult)&&(identical(other.error, error) || other.error == error)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_customers),const DeepCollectionEquality().hash(_customerSearchResults),selectedCustomer,const DeepCollectionEquality().hash(_enrollments),selectedEnrollment,customerDetailData,const DeepCollectionEquality().hash(_invoices),totalDue,isLoading,isSearchingCustomers,isLoadingEnrollments,paymentResult,error,successMessage);

@override
String toString() {
  return 'CustomerState(customers: $customers, customerSearchResults: $customerSearchResults, selectedCustomer: $selectedCustomer, enrollments: $enrollments, selectedEnrollment: $selectedEnrollment, customerDetailData: $customerDetailData, invoices: $invoices, totalDue: $totalDue, isLoading: $isLoading, isSearchingCustomers: $isSearchingCustomers, isLoadingEnrollments: $isLoadingEnrollments, paymentResult: $paymentResult, error: $error, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$CustomerStateCopyWith<$Res> implements $CustomerStateCopyWith<$Res> {
  factory _$CustomerStateCopyWith(_CustomerState value, $Res Function(_CustomerState) _then) = __$CustomerStateCopyWithImpl;
@override @useResult
$Res call({
 List<Customer> customers, List<Customer> customerSearchResults, Customer? selectedCustomer, List<Enrollment> enrollments, Enrollment? selectedEnrollment, CustomerDetailData? customerDetailData, List<Invoice> invoices, double totalDue, bool isLoading, bool isSearchingCustomers, bool isLoadingEnrollments, PaymentResult? paymentResult, String? error, String? successMessage
});




}
/// @nodoc
class __$CustomerStateCopyWithImpl<$Res>
    implements _$CustomerStateCopyWith<$Res> {
  __$CustomerStateCopyWithImpl(this._self, this._then);

  final _CustomerState _self;
  final $Res Function(_CustomerState) _then;

/// Create a copy of CustomerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customers = null,Object? customerSearchResults = null,Object? selectedCustomer = freezed,Object? enrollments = null,Object? selectedEnrollment = freezed,Object? customerDetailData = freezed,Object? invoices = null,Object? totalDue = null,Object? isLoading = null,Object? isSearchingCustomers = null,Object? isLoadingEnrollments = null,Object? paymentResult = freezed,Object? error = freezed,Object? successMessage = freezed,}) {
  return _then(_CustomerState(
customers: null == customers ? _self._customers : customers // ignore: cast_nullable_to_non_nullable
as List<Customer>,customerSearchResults: null == customerSearchResults ? _self._customerSearchResults : customerSearchResults // ignore: cast_nullable_to_non_nullable
as List<Customer>,selectedCustomer: freezed == selectedCustomer ? _self.selectedCustomer : selectedCustomer // ignore: cast_nullable_to_non_nullable
as Customer?,enrollments: null == enrollments ? _self._enrollments : enrollments // ignore: cast_nullable_to_non_nullable
as List<Enrollment>,selectedEnrollment: freezed == selectedEnrollment ? _self.selectedEnrollment : selectedEnrollment // ignore: cast_nullable_to_non_nullable
as Enrollment?,customerDetailData: freezed == customerDetailData ? _self.customerDetailData : customerDetailData // ignore: cast_nullable_to_non_nullable
as CustomerDetailData?,invoices: null == invoices ? _self._invoices : invoices // ignore: cast_nullable_to_non_nullable
as List<Invoice>,totalDue: null == totalDue ? _self.totalDue : totalDue // ignore: cast_nullable_to_non_nullable
as double,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSearchingCustomers: null == isSearchingCustomers ? _self.isSearchingCustomers : isSearchingCustomers // ignore: cast_nullable_to_non_nullable
as bool,isLoadingEnrollments: null == isLoadingEnrollments ? _self.isLoadingEnrollments : isLoadingEnrollments // ignore: cast_nullable_to_non_nullable
as bool,paymentResult: freezed == paymentResult ? _self.paymentResult : paymentResult // ignore: cast_nullable_to_non_nullable
as PaymentResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
