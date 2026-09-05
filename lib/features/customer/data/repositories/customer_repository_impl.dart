import 'package:dartz/dartz.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/enrollment.dart';
import 'package:komet_collection/features/customer/domain/entities/invoice.dart';
import 'package:komet_collection/features/customer/domain/entities/payment.dart';
import 'package:komet_collection/features/customer/domain/entities/payment_result.dart';
import 'package:komet_collection/features/customer/domain/repositories/customer_repository.dart';
import 'package:komet_collection/core/error/failures.dart';
import 'package:komet_collection/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:komet_collection/features/customer/data/models/invoice_model.dart';
import 'package:komet_collection/features/customer/data/models/payment_model.dart';
import 'package:komet_collection/features/customer/domain/entities/customer_detail_data.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource _remoteDataSource;

  CustomerRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Customer>>> getCustomers({
    int page = 1,
    int pageSize = 100,
    String? search,
  }) async {
    try {
      final results = await _remoteDataSource.getCustomers(
        page: page,
        pageSize: pageSize,
        search: search,
      );
      return Right(results);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Enrollment>>> getEnrollments({
    required int customerId,
    String status = 'active',
  }) async {
    try {
      final results = await _remoteDataSource.getEnrollments(
        customerId: customerId,
        status: status,
      );
      return Right(results);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, CustomerDetailData>> getCustomerDetail(String id) async {
    try {
      final detailData = await _remoteDataSource.getCustomerDetail(id);
      return Right(detailData);
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
  Future<Either<Failure, PaymentResult>> collectPayment({
    required int enrollmentId,
    required double amount,
    String? paymentDate,
    String paymentMode = 'cash',
    String? notes,
  }) async {
    try {
      final result = await _remoteDataSource.collectPayment(
        enrollmentId: enrollmentId,
        amount: amount,
        paymentDate: paymentDate,
        paymentMode: paymentMode,
        notes: notes,
      );
      return Right(result);
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
