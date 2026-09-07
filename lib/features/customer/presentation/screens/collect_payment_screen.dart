import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_bloc.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_event.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_state.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';
import 'package:komet_collection/features/customer/domain/entities/enrollment.dart';
import 'package:komet_collection/features/customer/domain/entities/payment_result.dart';

@RoutePage()
class CollectPaymentScreen extends StatefulWidget {
  final Customer customer;
  const CollectPaymentScreen({super.key, required this.customer});

  @override
  State<CollectPaymentScreen> createState() => _CollectPaymentScreenState();
}

class _CollectPaymentScreenState extends State<CollectPaymentScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _selectedMode = 'cash'; // 'cash', 'upi', 'card', 'cheque'

  final List<Map<String, String>> _paymentModes = [
    {'label': 'Cash', 'value': 'cash'},
    {'label': 'UPI', 'value': 'upi'},
    {'label': 'Card', 'value': 'card'},
    {'label': 'Cheque', 'value': 'cheque'},
  ];

  @override
  void initState() {
    super.initState();
    final bloc = context.read<CustomerBloc>();
    bloc.add(const CustomerEvent.clearMessages());
    bloc.add(CustomerEvent.selectCustomer(customer: widget.customer));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onEnrollmentSelected(Enrollment? enrollment) {
    context.read<CustomerBloc>().add(CustomerEvent.selectEnrollment(enrollment: enrollment));
    if (enrollment != null) {
      _amountController.text = enrollment.installmentAmount.toStringAsFixed(2);
    }
  }

  Future<void> _selectPaymentDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0F172A),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitPayment(CustomerState state) {
    final enrollment = state.selectedEnrollment;
    if (enrollment == null) {
      _showErrorSnackBar('Please select an active scheme enrollment');
      return;
    }

    if (_amountController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter a valid amount');
      return;
    }

    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      _showErrorSnackBar('Amount must be greater than 0');
      return;
    }

    final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    context.read<CustomerBloc>().add(
          CustomerEvent.submitCollectPayment(
            enrollmentId: enrollment.id,
            amount: amount,
            paymentDate: formattedDate,
            paymentMode: _selectedMode,
            notes: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
          ),
        );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showReceiptDialog(PaymentResult receipt) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD1FAE5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF059669),
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Payment Collected!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Receipt Number: ${receipt.receiptNumber}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        _buildReceiptRow('Amount Paid', '₹${receipt.amount.toStringAsFixed(2)}', isBold: true, isPrice: true),
                        const Divider(height: 14, color: Color(0xFFE2E8F0)),
                        if (receipt.customerName != null)
                          _buildReceiptRow('Customer', receipt.customerName!),
                        if (receipt.schemeName != null)
                          _buildReceiptRow('Scheme', receipt.schemeName!),
                        _buildReceiptRow('Payment Mode', receipt.paymentMode.toUpperCase()),
                        if (receipt.paymentDate != null)
                          _buildReceiptRow('Payment Date', receipt.paymentDate!),
                        _buildReceiptRow('Transaction ID', '#${receipt.transactionId}'),
                        if (receipt.receivedBy != null)
                          _buildReceiptRow('Received By', receipt.receivedBy!),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final bloc = context.read<CustomerBloc>();
                        final customerId = widget.customer.id;
                        Navigator.of(dialogContext).pop();
                        bloc.add(const CustomerEvent.clearMessages());
                        context.router.pop(true);
                        bloc.add(CustomerEvent.loadLedger(customerId: customerId));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isBold = false, bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: isPrice ? 16 : 13,
                fontWeight: isBold || isPrice ? FontWeight.bold : FontWeight.w600,
                color: isPrice ? const Color(0xFF059669) : const Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Collect Payment',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state.paymentResult != null) {
            _showReceiptDialog(state.paymentResult!);
          } else if (state.error != null) {
            _showErrorSnackBar(state.error!);
            context.read<CustomerBloc>().add(const CustomerEvent.clearMessages());
          }
        },
        builder: (context, state) {
          final enrollments = state.enrollments;
          final selectedEnrollment = state.selectedEnrollment;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CUSTOMER INFO TILE (PRE-SELECTED & NON-EDITABLE)
                _buildCustomerTile(widget.customer),

                const SizedBox(height: 20),

                // SCHEME ENROLLMENT SELECTION
                _buildSectionHeader('Select Scheme Enrollment', Icons.card_membership_rounded),
                const SizedBox(height: 8),
                _buildEnrollmentPickerSection(state, enrollments, selectedEnrollment),

                const SizedBox(height: 20),

                // PAYMENT DETAILS FORM
                _buildSectionHeader('Payment Details', Icons.payments_rounded),
                const SizedBox(height: 12),
                _buildPaymentFormCard(),

                const SizedBox(height: 28),

                // SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (state.isLoading || selectedEnrollment == null)
                        ? null
                        : () => _submitPayment(state),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      disabledBackgroundColor: const Color(0xFFCBD5E1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth: 2,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline_rounded, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Confirm & Collect Payment',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF4F46E5)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerTile(Customer customer) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    customer.name.isNotEmpty ? customer.name[0].toUpperCase() : 'C',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Phone: ${customer.phone}${customer.code != null && customer.code!.isNotEmpty ? ' • Code: ${customer.code}' : ''}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Due Amount', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                    Text(
                      '₹${customer.totalDue.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: customer.totalDue > 0 ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
                if (customer.overdueAmount > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Overdue', style: TextStyle(fontSize: 11, color: Color(0xFFEF4444))),
                      Text(
                        '₹${customer.overdueAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFEF4444)),
                      ),
                    ],
                  ),
                if (customer.nextDueDate != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Next Due Date', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      Text(
                        customer.nextDueDate!,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnrollmentPickerSection(
    CustomerState state,
    List<Enrollment> enrollments,
    Enrollment? selectedEnrollment,
  ) {
    if (state.isLoadingEnrollments) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Color(0xFF4F46E5))),
            ),
            SizedBox(width: 12),
            Text('Fetching customer scheme enrollments...', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
          ],
        ),
      );
    }

    if (enrollments.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFCA5A5)),
        ),
        child: const Row(
          children: [
            Icon(Icons.info_outline_rounded, color: Color(0xFFEF4444), size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'No active scheme enrollments found for this customer.',
                style: TextStyle(fontSize: 13, color: Color(0xFF991B1B), fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<Enrollment>(
          value: selectedEnrollment,
          items: enrollments.map((e) {
            return DropdownMenuItem<Enrollment>(
              value: e,
              child: Text(
                '${e.schemeName} (ID: #${e.id}) - ₹${e.installmentAmount.toStringAsFixed(2)}/slot',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: _onEnrollmentSelected,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
            ),
          ),
        ),

        if (selectedEnrollment != null) ...[
          const SizedBox(height: 12),
          _buildEnrollmentDetailCard(selectedEnrollment),
        ],
      ],
    );
  }

  Widget _buildEnrollmentDetailCard(Enrollment enrollment) {
    final progressStr = '${enrollment.paidInstallments} of ${enrollment.totalInstallments}';
    final progressRatio = enrollment.totalInstallments > 0
        ? (enrollment.paidInstallments / enrollment.totalInstallments).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: enrollment.hasOverdue ? const Color(0xFFFCA5A5) : const Color(0xFFE2E8F0),
          width: enrollment.hasOverdue ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  enrollment.schemeName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: enrollment.status.toLowerCase() == 'active'
                      ? const Color(0xFFD1FAE5)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  enrollment.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: enrollment.status.toLowerCase() == 'active'
                        ? const Color(0xFF059669)
                        : const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMiniDetail('Installment', '₹${enrollment.installmentAmount.toStringAsFixed(2)}'),
              ),
              Expanded(
                child: _buildMiniDetail('Total Value', '₹${enrollment.totalSchemeAmount.toStringAsFixed(2)}'),
              ),
              Expanded(
                child: _buildMiniDetail('Balance Due', '₹${enrollment.balanceDue.toStringAsFixed(2)}', isDanger: enrollment.balanceDue > 0),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Installments: $progressStr', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                        Text('${(progressRatio * 100).toInt()}%', style: const TextStyle(fontSize: 11, color: Color(0xFF4F46E5), fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progressRatio,
                        minHeight: 6,
                        backgroundColor: const Color(0xFFEEF2FF),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (enrollment.nextDueDate != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.event_rounded, size: 14, color: Color(0xFF64748B)),
                const SizedBox(width: 6),
                Text(
                  'Next Due Date: ${enrollment.nextDueDate}',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF475569), fontWeight: FontWeight.w600),
                ),
                if (enrollment.hasOverdue) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'OVERDUE',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFEF4444)),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMiniDetail(String label, String value, {bool isDanger = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDanger ? const Color(0xFFEF4444) : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentFormCard() {
    final formattedDateStr = DateFormat('dd MMM yyyy').format(_selectedDate);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AMOUNT FIELD
          const Text('Collection Amount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
          const SizedBox(height: 6),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: '0.00',
              prefixText: '₹ ',
              prefixStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // PAYMENT DATE FIELD
          const Text('Payment Date', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
          const SizedBox(height: 6),
          InkWell(
            onTap: _selectPaymentDate,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 18, color: Color(0xFF4F46E5)),
                  const SizedBox(width: 10),
                  Text(
                    formattedDateStr,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
                  ),
                  const Spacer(),
                  const Icon(Icons.edit_calendar_rounded, size: 18, color: Color(0xFF64748B)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // PAYMENT MODE FIELD
          const Text('Payment Mode', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
          const SizedBox(height: 8),
          Row(
            children: _paymentModes.map((mode) {
              final isSelected = _selectedMode == mode['value'];
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: InkWell(
                    onTap: () => setState(() => _selectedMode = mode['value']!),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          mode['label']!,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // NOTES FIELD
          const Text('Notes / Remarks (Optional)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
          const SizedBox(height: 6),
          TextField(
            controller: _noteController,
            maxLines: 2,
            style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: 'Add counter reference or remarks...',
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
