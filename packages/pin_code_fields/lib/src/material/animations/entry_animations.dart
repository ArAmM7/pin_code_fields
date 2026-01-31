import 'package:flutter/material.dart';

import '../theme/material_pin_theme.dart';

/// Builds an entry animation transition for PIN cell content.
///
/// This creates the appropriate transition based on the animation type.
Widget buildEntryAnimation({
  required Widget child,
  required Animation<double> animation,
  required MaterialPinAnimation type,
}) {
  switch (type) {
    case MaterialPinAnimation.scale:
      return ScaleTransition(scale: animation, child: child);
    case MaterialPinAnimation.fade:
      return FadeTransition(opacity: animation, child: child);
    case MaterialPinAnimation.slide:
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    case MaterialPinAnimation.none:
      return child;
  }
}

/// Returns an AnimatedSwitcher transition builder for PIN cell entry animations.
AnimatedSwitcherTransitionBuilder getEntryAnimationTransitionBuilder(
  MaterialPinAnimation type,
  Curve curve,
) {
  return (Widget child, Animation<double> animation) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );
    return buildEntryAnimation(
      child: child,
      animation: curvedAnimation,
      type: type,
    );
  };
}
