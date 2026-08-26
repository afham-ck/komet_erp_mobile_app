import 'package:dartz/dartz.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/invoice.dart';
import 'package:komet_collection/features/customer/domain/entities/payment.dart';
import 'package:komet_collection/features/customer/domain/repositories/customer_repository.dart';
import 'package:komet_collection/core/error/failures.dart';
import 'package:komet_collection/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:komet_collection/features/customer/data/models/invoice_model.dart';
import 'package:komet_collection/features/customer/data/models/payment_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource _remoteDataSource;

  CustomerRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Customer>>> getCustomers({int offset = 0, int limit = 50}) async {
    try {
      final results = await _remoteDataSource.getCustomers(offset: offset, limit: limit);
      return Right(results);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, ({List<Invoice> invoices, double totalDue})>> getCustomerLedger(String customerId) async {
    try {
      final data = await _remoteDataSource.getCustomerLedger(customerId);
      final invoicesList = (data['invoices'] ?? []) as List;
      final invoices = invoicesList
          .map<Invoice>((inv) => InvoiceModel.fromJson(inv as Map<String, dynamic>))
          .toList();
      final double totalDue = (data['total_due'] ?? 0).toDouble();
      return Right((invoices: invoices, totalDue: totalDue));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Customer>> createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
    String? aadhar,
  }) async {
    try {
      final customer = await _remoteDataSource.createCustomer(
        name: name,
        phone: phone,
        email: email,
        address: address,
        aadhar: aadhar,
      );
      return Right(customer);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Payment>> recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  }) async {
    try {
      final response = await _remoteDataSource.recordPayment(
        customerId: customerId,
        amount: amount,
        paymentMode: paymentMode,
        note: note,
      );
      return Right(PaymentModel.fromJson(response));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
