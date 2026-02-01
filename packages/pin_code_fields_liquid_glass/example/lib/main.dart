import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields_liquid_glass/pin_code_fields_liquid_glass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Glass PIN Examples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// =============================================================================
// HOME SCREEN - Navigation to all examples
// =============================================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f3460)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Liquid Glass\nPIN Field',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'iOS 26 inspired glass effects',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 48),
                Expanded(
                  child: ListView(
                    children: [
                      _DemoCard(
                        icon: Icons.message_outlined,
                        title: 'OTP Verification',
                        subtitle: 'SMS code entry with countdown',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OtpVerificationScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _DemoCard(
                        icon: Icons.lock_outline,
                        title: 'Lock Screen',
                        subtitle: 'Device unlock style',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LockScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _DemoCard(
                        icon: Icons.payment_outlined,
                        title: 'Payment PIN',
                        subtitle: 'Transaction confirmation',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaymentPinScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _DemoCard(
                        icon: Icons.tune,
                        title: 'Playground',
                        subtitle: 'Customize all parameters',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PlaygroundScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// OTP VERIFICATION SCREEN
// =============================================================================

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _pinController = PinInputController();
  int _countdown = 30;
  Timer? _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _countdown = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  void _verifyOtp(String otp) async {
    setState(() => _isVerifying = true);

    // Simulate verification
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (otp == '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      _pinController.triggerError();
      _pinController.clear();
      setState(() => _isVerifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Scrollable background content
          _ScrollableBackground(
            imagePath: 'assets/images/bg2.jpg',
          ),

          // Fixed PIN entry UI on top
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  ),

                  const Spacer(),

                  // Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.message_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'Verify your number',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Enter the 6-digit code sent to\n+1 (555) 123-4567',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // PIN Field
                  LiquidGlassPinField(
                    length: 6,
                    pinController: _pinController,
                    theme: LiquidGlassPinTheme.blended(
                      cellSize: const Size(48, 56),
                      blur: 12,
                      blendAmount: 0.4,
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onCompleted: _verifyOtp,
                    enabled: !_isVerifying,
                  ),

                  const SizedBox(height: 32),

                  // Countdown / Resend
                  if (_countdown > 0)
                    Text(
                      'Resend code in ${_countdown}s',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: _startCountdown,
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  if (_isVerifying) ...[
                    const SizedBox(height: 24),
                    const CircularProgressIndicator(color: Colors.white),
                  ],

                  const Spacer(flex: 2),

                  // Hint
                  Text(
                    'Scroll background to see blur effect • Try: 123456',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// LOCK SCREEN
// =============================================================================

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final _pinController = PinInputController();
  String _timeString = '';
  String _dateString = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _timeString = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      _dateString = _formatDate(now);
    });
  }

  String _formatDate(DateTime date) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June',
                   'July', 'August', 'September', 'October', 'November', 'December'];
    return '${days[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  void _unlock(String pin) async {
    HapticFeedback.mediumImpact();

    if (pin == '1234') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unlocked!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      _pinController.triggerError();
      await Future.delayed(const Duration(milliseconds: 500));
      _pinController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Scrollable gradient background
          _ScrollableGradientBackground(
            colors: const [
              Color(0xFF0f0c29),
              Color(0xFF302b63),
              Color(0xFF24243e),
              Color(0xFF1a1a2e),
            ],
          ),

          // Fixed lock screen UI on top
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Time
                Text(
                  _timeString,
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                    letterSpacing: -2,
                  ),
                ),

                // Date
                Text(
                  _dateString,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),

                const Spacer(),

                // Lock icon
                Icon(
                  Icons.lock_outline,
                  size: 28,
                  color: Colors.white.withValues(alpha: 0.8),
                ),

                const SizedBox(height: 16),

                Text(
                  'Enter Passcode',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),

                const SizedBox(height: 32),

                // PIN Field - Separate style for lock screen
                // No cursor, no typed characters shown (fully obscured)
                LiquidGlassPinField(
                  length: 4,
                  pinController: _pinController,
                  obscureText: true,
                  blinkWhenObscuring: false,
                  // Custom dot widget for filled cells
                  obscuringWidget: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  theme: LiquidGlassPinTheme.separate(
                    cellSize: const Size(20, 20),
                    blur: 8,
                    spacing: 24,
                    borderRadius: 10,
                    showCursor: false, // No cursor for lock screen
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onCompleted: _unlock,
                ),

                const Spacer(),

                // Hint
                Text(
                  'Scroll background to see blur effect • Try: 1234',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 16),

                // Back button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Back to Examples',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// PAYMENT PIN SCREEN
// =============================================================================

class PaymentPinScreen extends StatefulWidget {
  const PaymentPinScreen({super.key});

  @override
  State<PaymentPinScreen> createState() => _PaymentPinScreenState();
}

class _PaymentPinScreenState extends State<PaymentPinScreen> {
  final _pinController = PinInputController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _confirmPayment(String pin) async {
    setState(() => _isProcessing = true);
    HapticFeedback.mediumImpact();

    // Simulate processing
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (pin == '000000') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      _pinController.triggerError();
      await Future.delayed(const Duration(milliseconds: 500));
      _pinController.clear();
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Scrollable background content
          _ScrollableBackground(imagePath: 'assets/images/bg2.jpg'),

          // Fixed payment UI on top
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock, size: 14, color: Colors.green),
                            SizedBox(width: 4),
                            Text(
                              'Secure',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Amount
                  const Text(
                    'Confirm Payment',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$1,249.99',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'to Apple Inc.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Divider
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    color: Colors.white.withValues(alpha: 0.1),
                  ),

                  const SizedBox(height: 48),

                  Text(
                    'Enter your 6-digit PIN',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // PIN Field - Unified style for payment
                  LiquidGlassPinField(
                    length: 6,
                    pinController: _pinController,
                    obscureText: true,
                    blinkWhenObscuring: false,
                    theme: LiquidGlassPinTheme.unified(
                      cellSize: const Size(48, 56),
                      blur: 15,
                      containerBorderRadius: 20,
                      dividerWidth: 1,
                      glassColor: Colors.white.withValues(alpha: 0.1),
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onCompleted: _confirmPayment,
                    enabled: !_isProcessing,
                  ),

                  const SizedBox(height: 32),

                  if (_isProcessing)
                    const Column(
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 16),
                        Text(
                          'Processing...',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),

                  const Spacer(),

                  // Hint
                  Text(
                    'Scroll background to see blur effect • Try: 000000',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Cancel button
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel Payment',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// PLAYGROUND SCREEN
// =============================================================================

enum GlassStyle { separate, unified, blended }

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  final _pinController = PinInputController();

  GlassStyle _style = GlassStyle.blended;
  int _length = 6;
  double _blur = 10;
  double _thickness = 20;
  double _cellWidth = 56;
  double _cellHeight = 64;
  bool _enableGlow = true;
  bool _enableStretch = true;
  bool _obscureText = false;
  bool _showCursor = true;

  // Glass settings
  double _visibility = 1.0;
  double _chromaticAberration = 0.01;
  double _lightIntensity = 0.5;
  double _ambientStrength = 0.0;
  double _refractiveIndex = 1.2;
  double _saturation = 1.5;

  // Glow settings
  double _glowRadius = 1.0;

  // Stretch settings
  double _stretchInteractionScale = 1.05;
  double _stretchAmount = 0.5;
  double _stretchResistance = 0.08;

  // Style-specific settings
  double _spacing = 8;
  double _separateBorderRadius = 12;
  double _dividerWidth = 1;
  double _containerBorderRadius = 16;
  double _blendAmount = 0.3;
  double _blendedBorderRadius = 12;

  int _backgroundIndex = 0;
  final _backgroundImages = [
    'assets/images/bg1.jpg',
    'assets/images/bg2.jpg',
    'assets/images/bg3.jpg',
    'assets/images/bg4.jpg',
    'assets/images/bg5.jpg',
  ];

  LiquidGlassPinTheme _buildTheme() {
    final cellSize = Size(_cellWidth, _cellHeight);

    switch (_style) {
      case GlassStyle.separate:
        return LiquidGlassPinTheme.separate(
          cellSize: cellSize,
          blur: _blur,
          thickness: _thickness,
          // Glass settings
          visibility: _visibility,
          chromaticAberration: _chromaticAberration,
          lightIntensity: _lightIntensity,
          ambientStrength: _ambientStrength,
          refractiveIndex: _refractiveIndex,
          saturation: _saturation,
          // Glow settings
          enableGlowOnFocus: _enableGlow,
          glowRadius: _glowRadius,
          // Stretch settings
          enableStretchAnimation: _enableStretch,
          stretchInteractionScale: _stretchInteractionScale,
          stretchAmount: _stretchAmount,
          stretchResistance: _stretchResistance,
          // Cursor
          showCursor: _showCursor,
          // Style-specific
          spacing: _spacing,
          borderRadius: _separateBorderRadius,
        );
      case GlassStyle.unified:
        return LiquidGlassPinTheme.unified(
          cellSize: cellSize,
          blur: _blur,
          thickness: _thickness,
          // Glass settings
          visibility: _visibility,
          chromaticAberration: _chromaticAberration,
          lightIntensity: _lightIntensity,
          ambientStrength: _ambientStrength,
          refractiveIndex: _refractiveIndex,
          saturation: _saturation,
          // Glow settings
          enableGlowOnFocus: _enableGlow,
          glowRadius: _glowRadius,
          // Stretch settings
          enableStretchAnimation: _enableStretch,
          stretchInteractionScale: _stretchInteractionScale,
          stretchAmount: _stretchAmount,
          stretchResistance: _stretchResistance,
          // Cursor
          showCursor: _showCursor,
          // Style-specific
          dividerWidth: _dividerWidth,
          containerBorderRadius: _containerBorderRadius,
        );
      case GlassStyle.blended:
        return LiquidGlassPinTheme.blended(
          cellSize: cellSize,
          blur: _blur,
          thickness: _thickness,
          // Glass settings
          visibility: _visibility,
          chromaticAberration: _chromaticAberration,
          lightIntensity: _lightIntensity,
          ambientStrength: _ambientStrength,
          refractiveIndex: _refractiveIndex,
          saturation: _saturation,
          // Glow settings
          enableGlowOnFocus: _enableGlow,
          glowRadius: _glowRadius,
          // Stretch settings
          enableStretchAnimation: _enableStretch,
          stretchInteractionScale: _stretchInteractionScale,
          stretchAmount: _stretchAmount,
          stretchResistance: _stretchResistance,
          // Cursor
          showCursor: _showCursor,
          // Style-specific
          blendAmount: _blendAmount,
          borderRadius: _blendedBorderRadius,
        );
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Scrollable background content
          _ScrollableBackground(imagePath: _backgroundImages[_backgroundIndex]),

          // Fixed playground UI on top
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                      const Text(
                        'Playground',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _backgroundIndex = (_backgroundIndex + 1) %
                                _backgroundImages.length;
                          });
                        },
                        icon: const Icon(Icons.palette, color: Colors.white),
                        tooltip: 'Change background',
                      ),
                    ],
                  ),
                ),

                // PIN Field Preview
                Expanded(
                  flex: 2,
                  child: Center(
                    child: LiquidGlassPinField(
                      length: _length,
                      theme: _buildTheme(),
                      pinController: _pinController,
                      obscureText: _obscureText,
                      onCompleted: (pin) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('PIN: $pin'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ActionButton(
                      label: 'Fill',
                      onPressed: () => _pinController.setText('1' * _length),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      label: 'Clear',
                      onPressed: () => _pinController.clear(),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      label: 'Error',
                      onPressed: () => _pinController.triggerError(),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Hint for scrolling
                Text(
                  'Scroll background to see blur effect',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                // Controls
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _SectionHeader('Style'),
                        SegmentedButton<GlassStyle>(
                          segments: const [
                            ButtonSegment(
                              value: GlassStyle.separate,
                              label: Text('Separate'),
                            ),
                            ButtonSegment(
                              value: GlassStyle.unified,
                              label: Text('Unified'),
                            ),
                            ButtonSegment(
                              value: GlassStyle.blended,
                              label: Text('Blended'),
                            ),
                          ],
                          selected: {_style},
                          onSelectionChanged: (s) => setState(() => _style = s.first),
                        ),

                        const SizedBox(height: 16),
                        _SectionHeader('Common'),
                        _SliderControl(
                          label: 'Length',
                          value: _length.toDouble(),
                          min: 4,
                          max: 8,
                          divisions: 4,
                          onChanged: (v) => setState(() => _length = v.round()),
                        ),
                        _SliderControl(
                          label: 'Blur',
                          value: _blur,
                          min: 0,
                          max: 30,
                          onChanged: (v) => setState(() => _blur = v),
                        ),
                        _SliderControl(
                          label: 'Thickness',
                          value: _thickness,
                          min: 5,
                          max: 50,
                          onChanged: (v) => setState(() => _thickness = v),
                        ),
                        _SliderControl(
                          label: 'Cell Width',
                          value: _cellWidth,
                          min: 40,
                          max: 80,
                          onChanged: (v) => setState(() => _cellWidth = v),
                        ),
                        _SliderControl(
                          label: 'Cell Height',
                          value: _cellHeight,
                          min: 48,
                          max: 96,
                          onChanged: (v) => setState(() => _cellHeight = v),
                        ),

                        SwitchListTile(
                          title: const Text('Obscure Text'),
                          value: _obscureText,
                          onChanged: (v) => setState(() => _obscureText = v),
                        ),
                        SwitchListTile(
                          title: const Text('Show Cursor'),
                          value: _showCursor,
                          onChanged: (v) => setState(() => _showCursor = v),
                        ),

                        const SizedBox(height: 16),
                        _SectionHeader('Glass Settings'),
                        _SliderControl(
                          label: 'Visibility',
                          value: _visibility,
                          min: 0,
                          max: 1,
                          onChanged: (v) => setState(() => _visibility = v),
                        ),
                        _SliderControl(
                          label: 'Chromatic',
                          value: _chromaticAberration,
                          min: 0,
                          max: 0.1,
                          onChanged: (v) => setState(() => _chromaticAberration = v),
                        ),
                        _SliderControl(
                          label: 'Light Intensity',
                          value: _lightIntensity,
                          min: 0,
                          max: 1,
                          onChanged: (v) => setState(() => _lightIntensity = v),
                        ),
                        _SliderControl(
                          label: 'Ambient',
                          value: _ambientStrength,
                          min: 0,
                          max: 1,
                          onChanged: (v) => setState(() => _ambientStrength = v),
                        ),
                        _SliderControl(
                          label: 'Refractive Idx',
                          value: _refractiveIndex,
                          min: 1.0,
                          max: 2.0,
                          onChanged: (v) => setState(() => _refractiveIndex = v),
                        ),
                        _SliderControl(
                          label: 'Saturation',
                          value: _saturation,
                          min: 0,
                          max: 3,
                          onChanged: (v) => setState(() => _saturation = v),
                        ),

                        const SizedBox(height: 16),
                        _SectionHeader('Glow'),
                        SwitchListTile(
                          title: const Text('Enable Glow'),
                          value: _enableGlow,
                          onChanged: (v) => setState(() => _enableGlow = v),
                        ),
                        _SliderControl(
                          label: 'Glow Radius',
                          value: _glowRadius,
                          min: 0,
                          max: 5,
                          onChanged: (v) => setState(() => _glowRadius = v),
                        ),

                        const SizedBox(height: 16),
                        _SectionHeader('Stretch Animation'),
                        SwitchListTile(
                          title: const Text('Enable Stretch'),
                          value: _enableStretch,
                          onChanged: (v) => setState(() => _enableStretch = v),
                        ),
                        _SliderControl(
                          label: 'Scale',
                          value: _stretchInteractionScale,
                          min: 1.0,
                          max: 1.2,
                          onChanged: (v) => setState(() => _stretchInteractionScale = v),
                        ),
                        _SliderControl(
                          label: 'Amount',
                          value: _stretchAmount,
                          min: 0,
                          max: 1,
                          onChanged: (v) => setState(() => _stretchAmount = v),
                        ),
                        _SliderControl(
                          label: 'Resistance',
                          value: _stretchResistance,
                          min: 0,
                          max: 0.2,
                          onChanged: (v) => setState(() => _stretchResistance = v),
                        ),

                        const SizedBox(height: 16),

                        if (_style == GlassStyle.separate) ...[
                          _SectionHeader('Separate Style'),
                          _SliderControl(
                            label: 'Spacing',
                            value: _spacing,
                            min: 0,
                            max: 24,
                            onChanged: (v) => setState(() => _spacing = v),
                          ),
                          _SliderControl(
                            label: 'Border Radius',
                            value: _separateBorderRadius,
                            min: 0,
                            max: 32,
                            onChanged: (v) => setState(() => _separateBorderRadius = v),
                          ),
                        ],

                        if (_style == GlassStyle.unified) ...[
                          _SectionHeader('Unified Style'),
                          _SliderControl(
                            label: 'Divider Width',
                            value: _dividerWidth,
                            min: 0,
                            max: 4,
                            onChanged: (v) => setState(() => _dividerWidth = v),
                          ),
                          _SliderControl(
                            label: 'Container Radius',
                            value: _containerBorderRadius,
                            min: 0,
                            max: 32,
                            onChanged: (v) => setState(() => _containerBorderRadius = v),
                          ),
                        ],

                        if (_style == GlassStyle.blended) ...[
                          _SectionHeader('Blended Style'),
                          _SliderControl(
                            label: 'Blend Amount',
                            value: _blendAmount,
                            min: 0,
                            max: 1,
                            onChanged: (v) => setState(() => _blendAmount = v),
                          ),
                          _SliderControl(
                            label: 'Border Radius',
                            value: _blendedBorderRadius,
                            min: 0,
                            max: 32,
                            onChanged: (v) => setState(() => _blendedBorderRadius = v),
                          ),
                        ],

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SHARED WIDGETS
// =============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _SliderControl extends StatelessWidget {
  const _SliderControl({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(label)),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            value.toStringAsFixed(value == value.roundToDouble() ? 0 : 1),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(onPressed: onPressed, child: Text(label));
  }
}

/// Scrollable background to demonstrate glass blur effect.
/// Scroll the background to see the blur in action.
class _ScrollableBackground extends StatelessWidget {
  const _ScrollableBackground({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Main image (larger than screen to allow scrolling)
          Image.asset(
            imagePath,
            width: size.width,
            height: size.height * 1.5,
            fit: BoxFit.cover,
          ),
          // Colorful gradient section
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFff6b6b),
                  Color(0xFFfeca57),
                  Color(0xFF48dbfb),
                  Color(0xFFff9ff3),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Scrollable gradient background for demonstrating glass blur effect.
class _ScrollableGradientBackground extends StatelessWidget {
  const _ScrollableGradientBackground({required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Main gradient section
          Container(
            width: size.width,
            height: size.height * 1.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
            ),
            child: Stack(
              children: [
                // Decorative circles for visual interest
                Positioned(
                  top: size.height * 0.1,
                  left: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.purple.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.4,
                  right: -30,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.blue.withValues(alpha: 0.25),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.2,
                  left: 50,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.indigo.withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Secondary gradient section
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colors.last,
                  const Color(0xFF1a1a2e),
                  const Color(0xFF16213e),
                  const Color(0xFF0f3460),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
