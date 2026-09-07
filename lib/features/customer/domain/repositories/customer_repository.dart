import 'package:dartz/dartz.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/enrollment.dart';
import 'package:komet_collection/features/customer/domain/entities/invoice.dart';
import 'package:komet_collection/features/customer/domain/entities/payment.dart';
import 'package:komet_collection/features/customer/domain/entities/payment_result.dart';
import 'package:komet_collection/core/error/failures.dart';

import 'package:komet_collection/features/customer/domain/entities/customer_detail_data.dart';

abstract class CustomerRepository {
  Future<Either<Failure, List<Customer>>> getCustomers({
    int page = 1,
    int pageSize = 100,
    String? search,
  });
  Future<Either<Failure, List<Enrollment>>> getEnrollments({
    required int customerId,
    String status = 'active',
  });
  Future<Either<Failure, CustomerDetailData>> getCustomerDetail(String id);
  Future<Either<Failure, ({List<Invoice> invoices, double totalDue})>> getCustomerLedger(String customerId);
  Future<Either<Failure, Customer>> createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
    String? aadhar,
  });
  Future<Either<Failure, PaymentResult>> collectPayment({
    required int enrollmentId,
    required double amount,
    String? paymentDate,
    String paymentMode = 'cash',
    String? notes,
  });
  Future<Either<Failure, Payment>> recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  });
}
