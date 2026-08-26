import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_bloc.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_event.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_state.dart';

@RoutePage()
class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _aadharController = TextEditingController();
  bool _showAdvanced = false;

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(const CustomerEvent.clearMessages());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _aadharController.dispose();
    super.dispose();
  }

  void _createCustomer() {
    if (_nameController.text.isEmpty) {
      _showError('Please enter customer name');
      return;
    }
    if (_phoneController.text.isEmpty) {
      _showError('Please enter phone number');
      return;
    }

    context.read<CustomerBloc>().add(CustomerEvent.createCustomer(
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text.isEmpty ? null : _emailController.text,
      address: _addressController.text.isEmpty ? null : _addressController.text,
      aadhar: _aadharController.text.isEmpty ? null : _aadharController.text,
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
      appBar: AppBar(title: const Text('Add Customer'), elevation: 0),
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
            context.read<CustomerBloc>().add(const CustomerEvent.clearMessages());
            context.router.pop();
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
                _buildField('Customer Name *', _nameController, hint: 'Enter full name'),
                const SizedBox(height: 16),
                _buildField('Phone Number *', _phoneController,
                    hint: 'Enter 10-digit phone number', prefix: '+91 ', keyboardType: TextInputType.phone),
                const SizedBox(height: 24),
                _buildAdvancedToggle(),
                if (_showAdvanced) ...[
                  const SizedBox(height: 16),
                  _buildField('Aadhar Number', _aadharController,
                      hint: 'Enter 12-digit Aadhar number', keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  _buildField('Email Address', _emailController,
                      hint: 'customer@example.com', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 16),
                  _buildField('Address', _addressController, hint: 'Enter full address', maxLines: 3),
                  const SizedBox(height: 24),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : _createCustomer,
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20, width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white), strokeWidth: 2),
                          )
                        : const Text('Add Customer'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {String? hint, String? prefix, TextInputType? keyboardType, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix,
          ),
        ),
      ],
    );
  }

  Widget _buildAdvancedToggle() {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => setState(() => _showAdvanced = !_showAdvanced),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              _showAdvanced ? Icons.expand_less : Icons.expand_more,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Advanced Information',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
