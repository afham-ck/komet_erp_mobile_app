import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/invoice.dart';

part 'customer_state.freezed.dart';

@freezed
abstract class CustomerState with _$CustomerState {
  const factory CustomerState({
    @Default([]) List<Customer> customers,
    @Default([]) List<Invoice> invoices,
    @Default(0.0) double totalDue,
    @Default(false) bool isLoading,
    String? error,
    String? successMessage,
  }) = _CustomerState;
}
