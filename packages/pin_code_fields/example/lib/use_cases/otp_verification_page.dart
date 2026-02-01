import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// OTP Verification - Most common use case
///
/// Features demonstrated:
/// - Auto-focus on load
/// - Clipboard detection with paste prompt
/// - Resend countdown timer
/// - Auto-submit on complete
/// - Error handling with shake
/// - Loading state during verification
class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _pinController = PinInputController();

  bool _isLoading = false;
  String? _clipboardCode;
  int _resendSeconds = 60;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendSeconds = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _verifyOtp(String otp) async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Simulate: "123456" is the correct OTP
    if (otp == '123456') {
      setState(() => _isLoading = false);
      _showSuccessDialog();
    } else {
      setState(() => _isLoading = false);
      _pinController.triggerError();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 64),
        title: const Text('Verified!'),
        content: const Text('Your phone number has been verified successfully.'),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _resendCode() {
    if (_resendSeconds > 0) return;

    _pinController.clear();
    _startResendTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification code sent!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _pasteCode() {
    if (_clipboardCode != null) {
      _pinController.setText(_clipboardCode!);
      setState(() => _clipboardCode = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Phone'),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.sms_outlined,
                      size: 40,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  Text(
                    'Verification Code',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'We sent a code to +1 (555) ***-1234',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // PIN Field
                  MaterialPinField(
                    length: 6,
                    pinController: _pinController,
                    autoFocus: true,
                    enabled: !_isLoading,
                    theme: MaterialPinTheme(
                      shape: MaterialPinShape.outlined,
                      cellSize: const Size(48, 56),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderWidth: 1.5,
                      focusedBorderWidth: 2,
                      focusedBorderColor: colorScheme.primary,
                      filledBorderColor: colorScheme.outline,
                      errorBorderWidth: 2,
                    ),
                    errorText: 'Invalid code. Please try again.',
                    onClipboardFound: (code) {
                      setState(() => _clipboardCode = code);
                    },
                    onCompleted: _verifyOtp,
                  ),
                  const SizedBox(height: 16),

                  // Paste from clipboard button
                  if (_clipboardCode != null)
                    FilledButton.tonal(
                      onPressed: _pasteCode,
                      child: Text('Paste $_clipboardCode'),
                    ),

                  const SizedBox(height: 24),

                  // Resend section
                  if (_resendSeconds > 0)
                    Text(
                      'Resend code in ${_formatTime(_resendSeconds)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    )
                  else
                    TextButton(
                      onPressed: _resendCode,
                      child: const Text('Resend Code'),
                    ),

                  const Spacer(flex: 2),

                  // Hint text
                  Text(
                    'Try entering 123456 for success',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Verifying...'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
