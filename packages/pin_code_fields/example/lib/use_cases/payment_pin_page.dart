import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// Payment Confirmation - Secure transaction PIN entry
///
/// Features demonstrated:
/// - Transaction summary display
/// - Secure PIN entry
/// - Processing state with read-only
/// - Success/failure feedback
/// - Cancel option
class PaymentPinPage extends StatefulWidget {
  const PaymentPinPage({super.key});

  @override
  State<PaymentPinPage> createState() => _PaymentPinPageState();
}

class _PaymentPinPageState extends State<PaymentPinPage> {
  final _pinController = PinInputController();

  bool _isProcessing = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _confirmPayment(String pin) async {
    setState(() => _isProcessing = true);

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Simulate: "1234" is the correct PIN
    if (pin == '1234') {
      _showSuccessDialog();
    } else {
      setState(() => _isProcessing = false);
      _pinController.triggerError();

      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          _pinController.clear();
        }
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 48,
          ),
        ),
        title: const Text('Payment Successful!'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('\$150.00 sent to'),
            SizedBox(height: 4),
            Text(
              'John Doe',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Payment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Transaction Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: colorScheme.primaryContainer,
                            child: const Text(
                              'JD',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'John Doe',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'john.doe@email.com',
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const Text(
                            '\$150.00',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fee',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '\$0.00',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // PIN Section
              Text(
                'Enter PIN to confirm',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),

              MaterialPinField(
                length: 4,
                pinController: _pinController,
                autoFocus: true,
                enabled: !_isProcessing,
                obscureText: true,
                hapticFeedbackType: HapticFeedbackType.medium,
                theme: MaterialPinTheme(
                  shape: MaterialPinShape.filled,
                  cellSize: const Size(56, 64),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  fillColor: colorScheme.surfaceContainerHighest,
                  focusedFillColor: colorScheme.primaryContainer,
                  errorFillColor: colorScheme.errorContainer,
                  obscuringCharacter: '●',
                  textStyle: const TextStyle(fontSize: 20),
                ),
                errorText: 'Incorrect PIN',
                onCompleted: _confirmPayment,
              ),

              const SizedBox(height: 24),

              // Processing indicator
              if (_isProcessing)
                Column(
                  children: [
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Processing payment...',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),

              const Spacer(),

              // Security note
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 16,
                    color: colorScheme.outline,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Secured with end-to-end encryption',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Hint
              Text(
                'Hint: PIN is 1234',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.outline,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
