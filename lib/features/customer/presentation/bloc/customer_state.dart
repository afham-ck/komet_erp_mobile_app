import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/customer_detail_data.dart';
import 'package:komet_collection/features/customer/domain/entities/enrollment.dart';
import 'package:komet_collection/features/customer/domain/entities/invoice.dart';
import 'package:komet_collection/features/customer/domain/entities/payment_result.dart';

part 'customer_state.freezed.dart';

@freezed
abstract class CustomerState with _$CustomerState {
  const factory CustomerState({
    @Default([]) List<Customer> customers,
    @Default([]) List<Customer> customerSearchResults,
    Customer? selectedCustomer,
    @Default([]) List<Enrollment> enrollments,
    Enrollment? selectedEnrollment,
    CustomerDetailData? customerDetailData,
    @Default([]) List<Invoice> invoices,
    @Default(0.0) double totalDue,
    @Default(false) bool isLoading,
    @Default(false) bool isSearchingCustomers,
    @Default(false) bool isLoadingEnrollments,
    PaymentResult? paymentResult,
    String? error,
    String? successMessage,
  }) = _CustomerState;
}
