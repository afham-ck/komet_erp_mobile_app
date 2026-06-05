import '../../domain/entities/invoice.dart';

class InvoiceModel extends Invoice {
  const InvoiceModel({
    required super.id,
    required super.date,
    required super.items,
    required super.amount,
    required super.paid,
    required super.balance,
    super.isOverdue,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date'] ?? json['invoice_date'] ?? DateTime.now().toIso8601String());
    final amount = (json['amount'] ?? json['total_amount'] ?? 0).toDouble();
    final paid = (json['paid_amount'] ?? json['paid'] ?? 0).toDouble();
    final isOverdue = json['is_overdue'] ?? (DateTime.now().difference(date).inDays > 30);

    return InvoiceModel(
      id: json['id'] ?? json['invoice_id'] ?? '',
      date: date,
      items: json['items'] ?? json['description'] ?? '',
      amount: amount,
      paid: paid,
      balance: amount - paid,
      isOverdue: isOverdue,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'items': items,
    'amount': amount,
    'paid': paid,
    'balance': balance,
    'is_overdue': isOverdue,
  };
}
