import '../../domain/entities/customer.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_remote_datasource.dart';
import '../models/invoice_model.dart';
import '../models/payment_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource _remoteDataSource;

  CustomerRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Customer>> getCustomers({int offset = 0, int limit = 50}) async {
    return _remoteDataSource.getCustomers(offset: offset, limit: limit);
  }

  @override
  Future<({List<Invoice> invoices, double totalDue})> getCustomerLedger(String customerId) async {
    final data = await _remoteDataSource.getCustomerLedger(customerId);
    final invoicesList = (data['invoices'] ?? []) as List;
    final invoices = invoicesList
        .map<Invoice>((inv) => InvoiceModel.fromJson(inv as Map<String, dynamic>))
        .toList();
    final double totalDue = (data['total_due'] ?? 0).toDouble();
    return (invoices: invoices, totalDue: totalDue);
  }

  @override
  Future<Customer> createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
  }) async {
    return _remoteDataSource.createCustomer(
      name: name,
      phone: phone,
      email: email,
      address: address,
    );
  }

  @override
  Future<Payment> recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  }) async {
    final response = await _remoteDataSource.recordPayment(
      customerId: customerId,
      amount: amount,
      paymentMode: paymentMode,
      note: note,
    );
    return PaymentModel.fromJson(response);
  }
}
