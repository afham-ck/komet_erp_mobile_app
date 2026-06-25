import 'package:dartz/dartz.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/invoice.dart';
import 'package:komet_collection/features/customer/domain/entities/payment.dart';
import 'package:komet_collection/core/error/failures.dart';

abstract class CustomerRepository {
  Future<Either<Failure, List<Customer>>> getCustomers({int offset = 0, int limit = 50});
  Future<Either<Failure, ({List<Invoice> invoices, double totalDue})>> getCustomerLedger(String customerId);
  Future<Either<Failure, Customer>> createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
  });
  Future<Either<Failure, Payment>> recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  });
}
