import 'package:flutter/services.dart';

/// Types of haptic feedback that can be triggered.
enum HapticFeedbackType {
  /// A light impact haptic feedback.
  light,

  /// A medium impact haptic feedback.
  medium,

  /// A heavy impact haptic feedback.
  heavy,

  /// A selection click haptic feedback.
  selection,

  /// A generic vibration.
  vibrate,
}

/// Triggers haptic feedback of the specified type.
void triggerHaptic(HapticFeedbackType type) {
  switch (type) {
    case HapticFeedbackType.light:
      HapticFeedback.lightImpact();
    case HapticFeedbackType.medium:
      HapticFeedback.mediumImpact();
    case HapticFeedbackType.heavy:
      HapticFeedback.heavyImpact();
    case HapticFeedbackType.selection:
      HapticFeedback.selectionClick();
    case HapticFeedbackType.vibrate:
      HapticFeedback.vibrate();
  }
}
