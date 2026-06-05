import '../../domain/entities/payment.dart';

class PaymentModel extends Payment {
  const PaymentModel({
    required super.id,
    required super.customerId,
    required super.amount,
    required super.mode,
    required super.date,
    super.note,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] ?? '',
      customerId: json['customer_id'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      mode: json['payment_mode'] ?? json['mode'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      note: json['note'] ?? json['notes'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'customer_id': customerId,
    'amount': amount,
    'payment_mode': mode,
    'date': date.toIso8601String(),
    'note': note,
  };
}
