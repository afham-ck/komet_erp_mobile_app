import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';
import '../../domain/entities/customer.dart';

class CollectPaymentScreen extends StatefulWidget {
  final Customer customer;
  const CollectPaymentScreen({Key? key, required this.customer}) : super(key: key);

  @override
  State<CollectPaymentScreen> createState() => _CollectPaymentScreenState();
}

class _CollectPaymentScreenState extends State<CollectPaymentScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedMode = 'Cash';

  final List<String> paymentModes = ['Cash', 'UPI', 'Card'];

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _recordPayment() async {
    if (_amountController.text.isEmpty) {
      _showError('Please enter an amount');
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }

    final provider = context.read<CustomerProvider>();
    final success = await provider.recordPayment(
      customerId: widget.customer.id,
      amount: amount,
      paymentMode: _selectedMode,
      note: _noteController.text.isEmpty ? null : _noteController.text,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment recorded successfully!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      _amountController.clear();
      _noteController.clear();
      Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
    } else if (provider.error != null) {
      _showError(provider.error!);
    }
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Collect Payment'), elevation: 0),
      body: Consumer<CustomerProvider>(
        builder: (context, provider, _) {
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
                    onPressed: provider.isLoading ? null : _recordPayment,
                    child: provider.isLoading
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
