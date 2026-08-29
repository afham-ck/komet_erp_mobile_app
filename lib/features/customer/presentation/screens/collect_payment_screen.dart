import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_bloc.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_event.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_state.dart';
import 'package:komet_collection/features/customer/domain/entities/customer.dart';

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
  String _selectedMode = 'Cash';

  final List<String> paymentModes = ['Cash', 'UPI', 'Card'];

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(const CustomerEvent.clearMessages());
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _recordPayment() {
    if (_amountController.text.isEmpty) {
      _showError('Please enter an amount');
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }

    context.read<CustomerBloc>().add(CustomerEvent.recordPayment(
      customerId: widget.customer.id,
      amount: amount,
      paymentMode: _selectedMode,
      note: _noteController.text.isEmpty ? null : _noteController.text,
    ));
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collect Payment'), elevation: 0),
      body: BlocConsumer<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            _amountController.clear();
            _noteController.clear();
            final router = context.router;
            context.read<CustomerBloc>().add(const CustomerEvent.clearMessages());
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) router.pop();
            });
          } else if (state.error != null) {
            _showError(state.error!);
            context.read<CustomerBloc>().add(const CustomerEvent.clearMessages());
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomerInfo(),
                const SizedBox(height: 24),
                _buildSectionTitle('Amount'),
                const SizedBox(height: 8),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter amount',
                    prefixText: '₹ ',
                    prefixStyle: TextStyle(fontSize: 18),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Payment Mode'),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  segments: paymentModes
                      .map((m) => ButtonSegment(label: Text(m), value: m))
                      .toList(),
                  selected: {_selectedMode},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() => _selectedMode = newSelection.first);
                  },
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Note (Optional)'),
                const SizedBox(height: 8),
                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Add any notes or reference',
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : _recordPayment,
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20, width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white), strokeWidth: 2),
                          )
                        : const Text('Confirm Payment'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomerInfo() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer', style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(widget.customer.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'Outstanding: ₹${widget.customer.totalDue.toStringAsFixed(2)}',
            style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}
