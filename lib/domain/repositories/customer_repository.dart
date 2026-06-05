import '../entities/customer.dart';
import '../entities/invoice.dart';
import '../entities/payment.dart';
import '../../core/error/failures.dart';

abstract class CustomerRepository {
  Future<List<Customer>> getCustomers({int offset, int limit});
  Future<({List<Invoice> invoices, double totalDue})> getCustomerLedger(String customerId);
  Future<Customer> createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
  });
  Future<Payment> recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  });
}
