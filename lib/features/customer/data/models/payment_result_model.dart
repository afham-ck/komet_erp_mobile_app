import 'package:komet_collection/features/customer/domain/entities/payment_result.dart';

double _parseDouble(dynamic val) {
  if (val == null) return 0.0;
  if (val is num) return val.toDouble();
  if (val is String) return double.tryParse(val) ?? 0.0;
  return 0.0;
}

int _parseInt(dynamic val) {
  if (val == null) return 0;
  if (val is num) return val.toInt();
  if (val is String) return int.tryParse(val) ?? 0;
  return 0;
}

List<int> _parseIntList(dynamic val) {
  if (val is List) {
    return val.map((e) => _parseInt(e)).toList();
  }
  return [];
}

class PaymentResultModel extends PaymentResult {
  const PaymentResultModel({
    required super.status,
    required super.transactionId,
    required super.receiptNumber,
    required super.amount,
    super.paymentDate,
    required super.paymentMode,
    super.receivedBy,
    super.createdByUsername,
    super.createdById,
    super.customerName,
    super.schemeName,
    required super.installmentsFullyPaid,
    required super.installmentsPartiallyPaid,
  });

  factory PaymentResultModel.fromJson(Map<String, dynamic> json) {
    return PaymentResultModel(
      status: json['status']?.toString() ?? 'recorded',
      transactionId: _parseInt(json['transaction_id'] ?? json['transactionId']),
      receiptNumber: json['receipt_number']?.toString() ?? json['receipt_no']?.toString() ?? '',
      amount: _parseDouble(json['amount']),
      paymentDate: json['payment_date']?.toString() ?? json['paymentDate']?.toString(),
      paymentMode: json['payment_mode']?.toString() ?? json['paymentMode']?.toString() ?? 'cash',
      receivedBy: json['received_by']?.toString() ?? json['receivedBy']?.toString(),
      createdByUsername: json['created_by_username']?.toString(),
      createdById: json['created_by_id'] != null ? _parseInt(json['created_by_id']) : null,
      customerName: json['customer_name']?.toString(),
      schemeName: json['scheme_name']?.toString(),
      installmentsFullyPaid: _parseIntList(json['installments_fully_paid']),
      installmentsPartiallyPaid: _parseIntList(json['installments_partially_paid']),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'transaction_id': transactionId,
        'receipt_number': receiptNumber,
        'amount': amount,
        'payment_date': paymentDate,
        'payment_mode': paymentMode,
        'received_by': receivedBy,
        'created_by_username': createdByUsername,
        'created_by_id': createdById,
        'customer_name': customerName,
        'scheme_name': schemeName,
        'installments_fully_paid': installmentsFullyPaid,
        'installments_partially_paid': installmentsPartiallyPaid,
      };
}
