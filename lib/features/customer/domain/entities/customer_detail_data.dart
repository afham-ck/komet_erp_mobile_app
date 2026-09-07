import 'customer_detail_entity.dart';
import 'customer_scheme.dart';
import 'customer_transaction.dart';

class CustomerDetailData {
  final CustomerDetailEntity customer;
  final List<CustomerScheme> schemes;
  final List<CustomerTransaction> transactions;

  const CustomerDetailData({
    required this.customer,
    this.schemes = const [],
    this.transactions = const [],
  });
}
